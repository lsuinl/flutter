import 'package:dio/dio.dart';
import 'package:dusty_dust/container/category_card.dart';
import 'package:dusty_dust/container/hourlycard.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../const/regions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = regions[0]; //기본은 0번째 지역먼저.
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    fetchData();
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  //dio로 api데이터요청하기
  Future<void> fetchData() async {
    try {
      final now = DateTime.now();
      final fetchTime = DateTime(now.year, now.month, now.day, now.hour);

      final box = Hive.box<StatModel>(ItemCode.PM10.name);

      List<Future> futures = [];
      if (box.values.isNotEmpty &&
          (box.values.last as StatModel).dataTime.isAtSameMomentAs(fetchTime)) {
        print("이미 최신 데이터가 있음");
        return;
      }
      for (ItemCode itemCode in ItemCode.values) {
        //데이터 하나씩 전부 불러와주기->await없기때문에 딜레이감소
        futures.add(
          StatRepository.fetchData(itemCode: itemCode),
        );
        //final Future<List<StatModel>> response =  StatRepository.fetchData( //await 하면 future불가.
        // final List<StatModel> response = await StatRepository.fetchData(
      }

      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        //ItemCode
        final key = ItemCode.values[i];
        //List<StatModel>
        final value = results[i];

        final box = Hive.box<StatModel>(key.name);
        for (StatModel stat in value) {
          box.put(stat.dataTime.toString(), stat);
        }

        final allkey = box.keys.toList();
        if (allkey.length > 24) {
          final deletekey = allkey.sublist(0, allkey.length - 24);
          box.deleteAll(deletekey);
        }
      }
    } on DioError catch (e) {
      //인터넷으로인한요청불가
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("인터넷 연결이 원활하지 않습니다.")));
    }
  }

  scrollListener() {
    bool isExpanded =
        scrollController.offset < 500 - kToolbarHeight; //offset: 스크롤 정도를 측정해줌
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
      builder: (context, box, widget) {
        if (box.values.isNotEmpty) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        //box =PM10(미세먼지)
        //리스트의 가장 앞에있는 데이터가 가장 최근 데이터임(날ㅅ짜)
        //미세먼지 최근 데이터의 현재상태
        final recentStat = box.values.toList().last as StatModel;
        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: recentStat.getLevelFromRegion(region),
          itemCode: ItemCode.PM10,
        );

        return Scaffold(
            drawer: MainDrawer(
              darkColor: status.darkColor,
              lightColor: status.lightColor,
              selectedRegion: region,
              onRegionTap: (String region) {
                setState(() {
                  this.region = region;
                });
                Navigator.of(context).pop(); //뒤로가기. drawer도 하나의 화면으로 인식.
              },
            ),
            body: Container(
              color: status.primaryColor,
              child: RefreshIndicator(
                //땡기면 새로고침(initstate)
                onRefresh: () async {
                  await fetchData();
                },
                child: CustomScrollView(
                  controller: scrollController,
                  //스크롤뷰
                  slivers: [
                    MainAppBar(
                      isExpanded: isExpanded,
                      region: region,
                      dateTime: recentStat.dataTime,
                      status: status,
                      stat: recentStat,
                    ),
                    SliverToBoxAdapter(
                      //슬리버가 아닌 위젯도 넣을 수 있도록
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CategoryCard(
                            darkColor: status.darkColor,
                            lightColor: status.lightColor,
                            region: region,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ...ItemCode.values.map(
                            //6가지항목모두 시간별로 나열
                            (itemCode) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: HourlyCard(
                                  itemCode: itemCode,
                                  region: region,
                                  darkColor: status.darkColor,
                                  lightColor: status.lightColor,
                                ),
                              );
                            },
                          ).toList(),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
