import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime? selectedDay; //사용자 선택 날짜

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco =  BoxDecoration( //날짜컨테이너데코
      color: Colors.grey[200], //색상
      borderRadius: BorderRadius.circular(6), //둥글게둥글게
    );
    final defalutTextStyle=TextStyle( //날짜 스타일
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );
    return TableCalendar( //테이블캘린더
        focusedDay: DateTime.now(), //선택 날짜
        firstDay: DateTime(1800), //선택할 수 있는 날짜 기간(처음)
        lastDay: DateTime(3000), //(끝)
      headerStyle: HeaderStyle( //상단스타일
        formatButtonVisible: false, //상단버튼활성화
        titleCentered: true, //중앙정렬
        titleTextStyle: TextStyle( //폰트
          fontWeight: FontWeight.w700,
          fontSize: 16,
        )
      ),
      calendarStyle: CalendarStyle(
        defaultDecoration: defaultBoxDeco, //평일용
        weekendDecoration:  defaultBoxDeco, //주말용
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all( //테두리색상
            color: PRIMARY_COLOR, //const에서 가져왔음!
            width: 1.0 //두께
          ),
        ),
        defaultTextStyle: defalutTextStyle, //글자스타일(평일)
        weekendTextStyle: defalutTextStyle,
        selectedTextStyle: defalutTextStyle.copyWith( //copyWith: 따로 지정한 값들만 변경하고 나머지는 똑같이
        color: PRIMARY_COLOR,
        ),
    ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay){
          setState(() {  //선택한 날짜저장
            this.selectedDay=selectedDay;
          });
      },
      selectedDayPredicate: (DateTime date){ //선택날짜 확인
          if(selectedDay==null){ //선택날짜없음
            return false;
          }
        return date.year == selectedDay!.year && //선택날짜로 변경
        date.month==selectedDay!.month &&
        date.day==selectedDay!.day;
    }
    );
  }
}
