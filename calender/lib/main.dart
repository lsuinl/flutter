import 'package:calender/Screen/component/calender.dart';
import 'package:calender/database/drift_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';//언어설정
import 'Screen/home_screen.dart';

const DEFAULT_COLORS=[
  //빨주노초파남보
  'F44336','FF9800','FFEB3B','FCAF50','2196F3','3F5185','9C3780'
];

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //초기화가 되었는지 확인.
//상단 코드는 runApp위젯에서도 실행되지만 실행이전에 우리는 한번 더 필요해서 쓰는것임
  await initializeDateFormatting(); //초기화(언어설정이 가능하도록)

  final database = LocalDatabase(); //데이터베이스 생성

  final colors= await database.getCategoryColors(); //색 가져오기
  if(colors.isEmpty){//데이터베이스에 이미 값이 저장되어있는지 확인
    for(String hexCode in DEFAULT_COLORS){ //색 넣어주기
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode:Value(hexCode)
        ),
      );
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData( //폰트테마설정
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    )
  );
}
