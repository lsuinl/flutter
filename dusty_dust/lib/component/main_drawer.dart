import 'package:flutter/material.dart';
import 'package:dusty_dust/const/colors.dart';
import '../const/regions.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;
  final String selectedRegion;

  const MainDrawer({
    required this.onRegionTap,
    required this.selectedRegion,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: dartColor,
      child: ListView(
        children: [
          DrawerHeader(
              //드로우헤더
              child: Text("지역 선택",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ))),
          ...regions
              .map(
                (e) => ListTile(
                  //... 리스트속에 리스트넣게해주기중요한 개념!
                  tileColor: Colors.white,
                  selectedTileColor: lightColor,
                  //선택된 상태에서 배경
                  selectedColor: Colors.black,
                  //글자
                  selected: e == selectedRegion,
                  //위에서 작성한 셀렉티드 컬러 속성들 사용여부(기본:흰색)
                  onTap: () {
                    onRegionTap(e);
                  },
                  title: Text(
                    e,
                  ),
                ),
              )
              .toList()
        ],
      ), //리스트뷰!
    );
  }
}
