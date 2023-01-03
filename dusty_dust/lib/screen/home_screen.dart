import 'package:dio/dio.dart';
import 'package:dusty_dust/component/category_card.dart';
import 'package:dusty_dust/component/hourlycard.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/data.dart';
import 'package:dusty_dust/const/status_level.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //dio로 api데이터요청하기
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();
    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        drawer: MainDrawer(),
        body: Center(
          child: FutureBuilder<List<StatModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Center(
                  child: Text("에러가 있습니다."),
                );
              }
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<StatModel> stats = snapshot.data!; //통계데이터 받아오기.
              StatModel recentStat= stats[0]; //리스트의 가장 앞에있는 데이터가 가장 최근 데이터임(날ㅅ짜)
              final status = DataUtils.getCurrentStatusFromStat(
                  value: recentStat.seoul,
                  itemCode: ItemCode.PM10
              );

              return CustomScrollView(
                //스크롤뷰
                slivers: [
                  MainAppBar(
                    status: status,
                    stat: recentStat,
                  ),
                  SliverToBoxAdapter(
                    //슬리버가 아닌 위젯도 넣을 수 있도록
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(),
                        const SizedBox(
                          height: 16,
                        ),
                        HourlyCard()
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ));
  }
}
