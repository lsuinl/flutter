import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

import 'card_title.dart';

class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;
  final List<StatAndStatusModel> models;

  const CategoryCard(
      {required this.darkColor,
      required this.lightColor,
      required this.region,
      required this.models,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Main_Card(
          backgroundColor: lightColor,
          child: LayoutBuilder(builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card_Title(
                  backgroundcolor: darkColor,
                  title: "종류별 통계",
                ),
                Expanded(
                  child: ListView(
                    //스크롤가능한 위젯들은 column안에 넣어줄 때 expanded로 감싸줘야함(필수)
                    //정렬
                    scrollDirection: Axis.horizontal, //스크롤 방향 설정
                    physics: PageScrollPhysics(), //페이지단위로 스크롤을 관리
                    children: models
                        .map(
                          (model) => MainStat(
                              category: DataUtils.getitemCodeKrString(
                                  itemCode: model.itemCode),
                              imgPath: model.status.imagePtth,
                              level: model.status.label,
                              stat: '${model.stat.getLevelFromRegion(
                                region,
                              )}${DataUtils.getUnitFromDataType(itemCode: model.itemCode)}',
                              width: constraint.maxWidth / 3),
                        )
                        .toList(),
                    //   List.generate(
                    //   20,
                    //   (index) => MainStat(
                    //     category: "미세먼지$index",
                    //     imgPath: "asset/img/best.png",
                    //     level: "최고",
                    //     stat: "0㎛",
                    //     width: constraint.maxWidth / 3,
                    //   ),
                    // ),
                  ),
                )
              ],
            );
          })),
    );
  }
}
