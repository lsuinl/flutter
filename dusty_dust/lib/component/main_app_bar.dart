import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/model/status_model.dart';
import 'package:dusty_dust/utils/data_utils.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final StatusModel status; // 가져온 스탯모델을 기준으로 단계를 나눠 만든 모델
  final StatModel stat; //실제 값 모델(요청해서 받아온 값)
  final String region;
  final DateTime dateTime;
  final bool isExpanded; //스크롤 모두 열림여부

  const MainAppBar(
      {required this.isExpanded,
      required this.dateTime,
      required this.status,
      required this.stat,
      required this.region,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      color: Colors.white,
      fontSize: 30,
    );

    return SliverAppBar(
      //앱바
      pinned: true,
      //앱바고정(스크롤에 영향받지 않음
      title: isExpanded
          ? null
          : Text(
              '${region} ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}'),
      centerTitle: true,
      //안드로이드용 센터정렬
      backgroundColor: status.primaryColor,
      expandedHeight: 500,
      //최대 늘어날 수 있는 값 설정
      flexibleSpace: FlexibleSpaceBar(
        //스크롤을 올리면 아이콘이 사라지는 공간
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),
            //컨테이너 밖. safearea와의 간격을 조정해줌
            //패딩: 컨테이너 내부를 조정, KToolBarHeight: 변수이며 앱바 높이를 알려줌
            child: Column(
              children: [
                Text(
                  region,
                  style: ts.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  status.imagePtth,
                  //미디어쿼리:현재 기기의. of(context)콘텐츠를 구성하는 size.width가로 사이즈의 /2 절반
                  width: MediaQuery.of(context).size.width / 2,
                ),
                Text(status.label,
                    style: ts.copyWith(
                        fontSize: 40.0, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 8.0,
                ),
                Text(status.comment,
                    style: ts.copyWith(
                        fontSize: 20.0, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
