import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight( //높이지정..row가 차지하는 최대 높이에서 설정
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                  startTime: startTime,
                  endTime: endTime),
              SizedBox(width: 16,),
              _Content(content: content),
              SizedBox(width: 16,),
              _Category(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime; //시작시간
  final int endTime;//종료시간
  
  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textstyle=TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${startTime.toString().padLeft(2,'0')}:00",
        style: textstyle,), //padLeft()최소 유지 문자갯수지정. 8을 입력해도 08로 될 수 있게
        Text("${endTime.toString().padLeft(2,'0')}:00",
        style: textstyle.copyWith(
          fontSize: 10,
        ),),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required  this.content,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(content));
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({
    required this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        width: 16,
        height: 16,
      ),
    );
  }
}

