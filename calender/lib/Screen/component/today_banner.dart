import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectDay; //선택한 날짜
  final int scheduleCount; //일정 개수

  const TodayBanner({
    required this.scheduleCount,
    required this.selectDay,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textstyle=TextStyle( //폰트스타일
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );


    return Container(
      color: PRIMARY_COLOR, //전체색상
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), //너비설정
        child: Row( //수평으로 나열
          mainAxisAlignment: MainAxisAlignment.spaceBetween,//넓게 분포하도록 정렬
          children: [
            Text('${selectDay.year}년 ${selectDay.month}월 ${selectDay.day}일' , //날짜
            style: textstyle,),
            Text('${scheduleCount}',//일정 개수
            style: textstyle,),
          ],
        ),
      ),
    );
  }
}
