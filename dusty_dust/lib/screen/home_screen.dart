import 'package:dusty_dust/component/category_card.dart';
import 'package:dusty_dust/component/hourlycard.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  //dio로 api데이터요청하기
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};
    List<Future> futures = [];

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
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }
    return stats;
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
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("에러가 있습니다."),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          Map<ItemCode, List<StatModel>> stats = snapshot.data!; //통계데이터 받아오기.
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

          //리스트의 가장 앞에있는 데이터가 가장 최근 데이터임(날ㅅ짜)
          //미세먼지 최근 데이터의 현재상태
          final status = DataUtils.getStatusFromItemCodeAndValue(
              value: pm10RecentStat.seoul, itemCode: ItemCode.PM10);

          final ssModel = stats.keys.map((key) {
            final value = stats[key]!;
            final stat = value[0];
            return StatAndStatusModel(
              itemCode: key,
              stat: stat,
              status: DataUtils.getStatusFromItemCodeAndValue(
                value: stat.getLevelFromRegion(region),
                itemCode: key,
              ),
            );
          }).toList();

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
                child: CustomScrollView(
                  controller: scrollController,
                  //스크롤뷰
                  slivers: [
                    MainAppBar(
                      isExpanded: isExpanded,
                      region: region,
                      dateTime: pm10RecentStat.dataTime,
                      status: status,
                      stat: pm10RecentStat,
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
                            models: ssModel,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ...stats.keys.map(
                            //6가지항목모두 시간별로 나열
                            (itemCode) {
                              final stat = stats[itemCode]!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: HourlyCard(
                                  category: DataUtils.getitemCodeKrString(
                                      itemCode: itemCode),
                                  stats: stat,
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
              ));
        });
  }
}
