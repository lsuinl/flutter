import 'package:calender/Screen/component/calender.dart';
import 'package:calender/Screen/component/schedule_card.dart';
import 'package:calender/Screen/component/today_banner.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay=DateTime( //선택날짜(null!이기 위해 now로 우선지정
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focuseDay=DateTime.now(); //선택날짜

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calender(
              focusedDay: focuseDay,
              selectedDay: selectedDay,
              onDaySelected: OnDaySelecte,),
            SizedBox(height: 8,),
            TodayBanner(
                scheduleCount:3,
                selectDay: selectedDay,),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ScheduleCard(
                  startTime: 12,
                  endTime: 14,
                  content: '프로그래밍 공부하기',
                  color:Colors.red,
              ),
            ),
          ],
        ),
      )
    );
  }

  OnDaySelecte(DateTime selectedDay, DateTime focusedDay){
    setState(() {  //선택한 날짜저장
      this.selectedDay=selectedDay;
      this.focuseDay=selectedDay;
    });
  }}
