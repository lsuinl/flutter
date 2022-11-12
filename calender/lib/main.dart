import 'package:calender/Screen/component/calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';//언어설정
import 'Screen/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //초기화가 되었는지 확인.
//상단 코드는 runApp위젯에서도 실행되지만 실행이전에 우리는 한번 더 필요해서 쓰는것임
  await initializeDateFormatting(); //초기화(언어설정이 가능하도록)

  runApp(
    MaterialApp(
      theme: ThemeData( //폰트테마설정
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    )
  );
}
