import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], //배경색
      body: SafeArea( //상단바 피하기
        bottom: false,
      child:Container(
        width: MediaQuery.of(context).size.width, //중앙정렬
        child: Column(
          children: [
            _TopPart(),
            _BottomPart(),
          ],
        )
      ),
    ),
    );
  }
}

class _TopPart extends StatelessWidget {
  const _TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text('U&I',
    style: TextStyle(
    color: Colors.white,
    fontFamily: 'paris',
    fontSize: 80,
    ),
    ),
    Column(children: [
      Text('우리 처음 만난 날',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'flower',
          fontSize: 30,
        ),
      ),
      Text('2022.07.23',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'flower',
          fontSize: 20,
        ),
      ),
    ],
    ),
    IconButton(
    iconSize: 60,
    onPressed: (){},
    icon: Icon(
    Icons.favorite,
    color: Colors.red,
    ),
    ),
    Text('D+1',
    style: TextStyle(
    color: Colors.white,
    fontFamily: 'flower',
    fontSize: 50,
    fontWeight: FontWeight.w700 //두께
    ),
    ),
    ],
      )
    );
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
