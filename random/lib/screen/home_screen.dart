import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random/component/number_row.dart';
import 'package:random/constant/color.dart';
import 'package:random/screen/setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber=1000;
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _top(
             onPressed: onSettingsPop,
            ),
            _middle(
              randomNumbers: randomNumbers,
            ),
            _bottom(onPressed: onRandomNumberGenerate),
          ],
        ),
      ),
      ),
    );
  }

  void onSettingsPop() async {
      final int? result= await Navigator.of(context).push<int>(
        MaterialPageRoute(
          builder: (BuildContext context){
            return SettingScreen(
              maxNumber: maxNumber,
            );
          },
        ),
      );
      if(result != null) {
        setState(() {
          maxNumber = result;
        });
      }
    }

  void onRandomNumberGenerate(){
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
    final number = rand.nextInt(maxNumber);
    newNumbers.add(number);
    }

    setState(() {
    randomNumbers = newNumbers.toList();
    });
  }
}

class _top extends StatelessWidget {
  final VoidCallback onPressed;

  const _top({required this.onPressed, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "랜덤 숫자 생성기",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            ),
          ),
        ],
    );
  }
}

class _middle extends StatelessWidget {

  final List<int> randomNumbers;

  const _middle({required this.randomNumbers, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(
                    number: x.value),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _bottom extends StatelessWidget {
  final VoidCallback onPressed;

  const _bottom({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              //박스사이즈 늘리기 Container 또는 Row 가능,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: RED_COLOR,
                ),
                onPressed: onPressed,
                child: Text('생성하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
