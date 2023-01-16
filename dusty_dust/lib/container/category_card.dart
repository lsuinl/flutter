import 'package:dusty_dust/component/card_title.dart';
import 'package:dusty_dust/component/main_card.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/model/stat_and_status_model.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class CategoryCard extends StatelessWidget {
  final String region;
  final Color darkColor;
  final Color lightColor;

  const CategoryCard(
      {required this.darkColor,
      required this.lightColor,
      required this.region,
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
                    children: ItemCode.values
                        .map((ItemCode itemCode) => ValueListenableBuilder<Box>(
                            valueListenable:
                                Hive.box<StatModel>(itemCode.name).listenable(),
                            builder: (cotext, box, widget) {
                              final stat = box.values.last as StatModel;
                              final status =
                                  DataUtils.getStatusFromItemCodeAndValue(
                                      value: stat.getLevelFromRegion(region),
                                      itemCode: itemCode);

                              return MainStat(
                                  category: DataUtils.getitemCodeKrString(
                                      itemCode: itemCode),
                                  imgPath: status.imagePtth,
                                  level: status.label,
                                  stat: '${stat.getLevelFromRegion(
                                    region,
                                  )}${DataUtils.getUnitFromDataType(itemCode: itemCode)}',
                                  width: constraint.maxWidth / 3);
                            }))
                        .toList(),
                  ),
                )
              ],
            );
          })),
    );
  }
}
