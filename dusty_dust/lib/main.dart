import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<StatModel>(StatModelAdapter()); //ß아답터등록
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  await Hive.openBox(testBox); //박스열기.
  for(ItemCode itemCode in ItemCode.values){
    await Hive.openBox<StatModel>(itemCode.name); //<statModel>로 상세정의
  }


  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'sunflower',
    ),
    home: HomeScreen(),
  ));
}
