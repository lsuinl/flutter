import 'package:dio/dio.dart';
import 'package:dusty_dust/component/category_card.dart';
import 'package:dusty_dust/component/hourlycard.dart';
import 'package:dusty_dust/component/main_app_bar.dart';
import 'package:dusty_dust/component/main_drawer.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:dusty_dust/const/data.dart';
import 'package:dusty_dust/model/stat_model.dart';
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
  fatechData()async{
    final response =  await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'itemCode':'PM10',
        'numOfRows':30,
        'pageNo':1,
        'dataGubun':'HOUR',
        'searchCodition':'WEEK'
      },
    );

    print(response.data['response']['body']['items'].map(
        (item)=> StatModel.fromJson(json: item),
    ));//data로 하면 body값을 모두 가져옴
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: Center(
        child: CustomScrollView( //스크롤뷰
          slivers: [
            MainAppBar(),
            SliverToBoxAdapter( //슬리버가 아닌 위젯도 넣을 수 있도록
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CategoryCard(),
                  const SizedBox(height: 16,),
                      HourlyCard()
                ],
                  ),
            ),
                ],
              ),
            )
        );
  }
}
