import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override //statful위젯 이므로 상태를 변경할 수 있도록 설정해줌
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  Timer? timer; //타이머 변수 설정
  PageController controller=PageController( initialPage: 0,); //페이지 컨트롤러 변수 설정/초기 페이지는 0

  @override
  //초기상태설정+타이머화면전환기능
  void initState() {
    // TODO: implement initState
    super.initState(); //데이터, 속성 등의 초기화.

    timer=Timer.periodic(Duration(seconds: 4), (timer) { //타이머의 주기는 4초. 4초마다 실행
      int currentpage=controller.page!.toInt(); //현재페이지를 컨트롤러의 페이지로
      int nextpage=currentpage+1; //다음 페이지를 현재페이지+1로

      if(nextpage>4){ //만약 다음 페이지가 4를 넘어가면
        nextpage=0; //0으로 초기화
      }
      controller.animateToPage(nextpage, duration: Duration(milliseconds: 500), curve: Curves.linear);
      //페이지를 처리하는 컨트롤러의 애니매이션 속성(넘어갈 인덱스,주기,변환애니매이션 유형
    });
  }

  @override
  //사라지기(메모리 절약용)
  void dispose() {
    controller.dispose();//컨트롤러야 사라져라 얍
    if(timer!=null) { //타이머의 값이 존재한다면
      timer!.cancel(); //타이머를 취소시켜줌
    }
    // TODO: implement dispose
    super.dispose(); //없애없애
  }
  @override
  //위젯!
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); //상태바 색 변경
    return Scaffold(
      body: PageView( //페이지변경
        controller: controller, //페이지 변경을 처리할 컨트롤러(페이지컨트롤러임)
        children: [1,2,3,4,5].map( //map함수를 이용한 이미지 불러오기(1~5번 이미지0
              (e) => Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover),
          //이미지를 불러오고, 크기는 화면에 꽉 채워서
      ).toList(), //map함수를 리스트화함
      ),
    );
  }
}
