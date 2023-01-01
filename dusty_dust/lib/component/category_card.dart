import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

import 'card_title.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Main_Card(child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card_Title(
              title: "종류별 통계",
            ),
            Expanded(
              child: ListView(
                //스크롤가능한 위젯들은 column안에 넣어줄 때 expanded로 감싸줘야함(필수)
                //정렬
                scrollDirection: Axis.horizontal, //스크롤 방향 설정
                physics: PageScrollPhysics(), //페이지단위로 스크롤을 관리
                children: List.generate(
                  20,
                  (index) => MainStat(
                    category: "미세먼지$index",
                    imgPath: "asset/img/best.png",
                    level: "최고",
                    stat: "0㎛",
                    width: constraint.maxWidth / 3,
                  ),
                ),
              ),
            )
          ],
        );
      })),
    );
  }
}
