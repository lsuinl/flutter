import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //ios와 비슷한 스타일 불러움

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], //배경색
      body: SafeArea(
        //상단바 피하기
        bottom: false,
        child: Container(
            width: MediaQuery.of(context).size.width, //중앙정렬
            child: Column(
              children: [
                _TopPart(
                  selectedDate: selectedDate,
                  onPressed: onHeartPressed,
                ),
                _BottomPart(),
              ],
            )),
      ),
    );
  }

  void onHeartPressed() {
    final DateTime now = DateTime.now();
    //dialog
    showCupertinoDialog(
      context: context,
      barrierDismissible: true, //해당 창 외에 다른 화면을 누르면 닫히게!!
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate, //초기날짜
                maximumDate: DateTime(
                  now.year,
                  now.month,
                  now.day,
                ),
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                }, //날짜나 시간이 바뀌었을 때,
              )),
        );
      },
    );
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final now = DateTime.now();

    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'U&I',
          style: textTheme.headline1,
        ),
        Column(
          children: [
            Text(
              '우리 처음 만난 날',
              style: textTheme.bodyText2,
            ),
            Text(
              '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
            style: textTheme.bodyText1,
            ),
          ],
        ),
        IconButton(
          iconSize: 60,
          onPressed: onPressed,
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        Text(
          'D+${DateTime(
                now.year,
                now.month,
                now.day,
              ).difference(selectedDate).inDays + 1}',
        style: textTheme.headline2,
        ),
      ],
    ));
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
