import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
               Expanded(child: _Logo()),
               Expanded(child: _Image()),
              Expanded(child: _Entrybutton()),
            ],
          ),
        ),
      )
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),//둥글게둥글게
          boxShadow:[
            BoxShadow(
              color: Colors.blue[300]!,
              blurRadius: 12.0, //그림자퍼짐정도
              spreadRadius: 2, //위와같음

            ),
          ], //박스컨테이너의 쉐도우
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam_sharp,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(width: 12,),
              Text(
                "LIVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 6 //글자 간 간격
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'asset/img/home_img.png'
      ),
    );
  }
}

class _Entrybutton extends StatelessWidget {
  const _Entrybutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: (){},
            child: Text("입장하기")),
      ],
    );
  }
}
