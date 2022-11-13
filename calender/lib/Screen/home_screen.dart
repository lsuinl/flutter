import 'package:calender/Screen/component/calender.dart';
import 'package:calender/Screen/component/schedule_bottom_sheet.dart';
import 'package:calender/Screen/component/schedule_card.dart';
import 'package:calender/Screen/component/today_banner.dart';
import 'package:calender/const/colors.dart';
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
      floatingActionButton: renderFloatingActionButton(),
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
           _Schedulelist(),
          ],
        ),
      )
    );
  }

  FloatingActionButton renderFloatingActionButton(){
    return FloatingActionButton(onPressed: (){
      showModalBottomSheet( //하단에 등장하는 모달창 두둥
          context: context, //내용
          isScrollControlled: true, //모달창 사이즈 한계 없애기
          builder: (_){
            return ScheduleBottomSheet();
          }
      );
    }, //플로팅버튼
        backgroundColor: PRIMARY_COLOR, //색상
        child: Icon( //버튼 아이콘
          Icons.add,
    )
    );
  }

  OnDaySelecte(DateTime selectedDay, DateTime focusedDay){
    setState(() {  //선택한 날짜저장
      this.selectedDay=selectedDay;
      this.focuseDay=selectedDay;
    });
  }}

class _Schedulelist extends StatelessWidget {
  const _Schedulelist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
              separatorBuilder: (context,index){
                return SizedBox(height:8); //아이템들 사이에 공백을 넣어줍니다
              },
              itemCount: 3,
              itemBuilder: (context,idex){
                return ScheduleCard(//보이는 아이템들만 빌드해주어서 효율적
                  startTime: 8,
                  endTime: 9,
                  content: '프로그래밍 공부하기',
                  color:Colors.red,
                );
              })
      ),
    );
  }
}
