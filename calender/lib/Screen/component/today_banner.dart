import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectDay;
  final int scheduleCount;

  const TodayBanner({
    required this.scheduleCount,
    required this.selectDay,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textstyle=TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );


    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), //너비설정
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,//정렬?
          children: [
            Text('${selectDay.year}년 ${selectDay.month}월 ${selectDay.day}일' ,
            style: textstyle,),
            Text('${scheduleCount}',
            style: textstyle,),
          ],
        ),
      ),
    );
  }
}
