import 'package:flutter/material.dart';
import 'package:dusty_dust/const/colors.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '충남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: dartColor,
      child: ListView(
        children: [
          DrawerHeader( //드로우헤더
              child: Text("지역 선택",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )
              )
          ),
         ...regions.map((e) =>  ListTile( //... 리스트속에 리스트넣게해주기중요한 개념!
             tileColor: Colors.white,
             selectedTileColor: lightColor, //선택된 상태에서 배경
             selectedColor: Colors.black,//글자
             selected: e=='서울', //위에서 작성한 셀렉티드 컬러 속성들 사용여부(기본:흰색)
             onTap: (){},
             title: Text(
               e,
             ),
         ),
         ).toList()
        ],
      ), //리스트뷰!
    );
  }
}
