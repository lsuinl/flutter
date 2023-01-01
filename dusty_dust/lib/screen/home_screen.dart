import 'package:dio/dio.dart';
import 'package:dusty_dust/component/category_card.dart';
import 'package:dusty_dust/component/hourlycard.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/data.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fatechData();
  }

  //dio로 api데이터요청하기
  fatechData() async {
    final statModels = await StatRepository.fetchData();

    print(statModels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        drawer: MainDrawer(),
        body: Center(
          child: CustomScrollView(
            //스크롤뷰
            slivers: [
              MainAppBar(),
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
          ),
        ));
  }
}
