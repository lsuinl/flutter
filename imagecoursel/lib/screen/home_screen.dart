import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Timer? timer;
  PageController controller=PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer=Timer.periodic(Duration(seconds: 4), (timer) {
      int currentpage=controller.page!.toInt();
      int nextpage=currentpage+1;

      if(nextpage>4){
        nextpage=0;
      }
      controller.animateToPage(nextpage, duration: Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    if(timer!=null) {
      timer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); //상태바 색 변경
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1,2,3,4,5].map(
              (e) => Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover),
      ).toList(),
      ),
    );
  }
}
