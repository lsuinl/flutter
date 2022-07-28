import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random/constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            _top(),
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

  void onRandomNumberGenerate(){
    final rand = Random();

    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
    final number = rand.nextInt(1000);
    newNumbers.add(number);
    }

    setState(() {
    randomNumbers = newNumbers.toList();
    });
  }
}

class _top extends StatelessWidget {
  const _top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "랜덤 숫자 생성기",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: () {},
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
              (x) =>
                  Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16),
                child: Row(
                  children: x
                      .toString()
                      .split('')
                      .map(
                        (y) => Image.asset(
                          'asset/img/$y.png',
                          height: 70,
                          width: 50,
                        ),
                      )
                      .toList(),
                ),
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
