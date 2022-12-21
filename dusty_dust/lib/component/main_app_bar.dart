import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';


class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts =TextStyle(
      color: Colors.white,
      fontSize: 30,
    );


    return  SliverAppBar( //앱바
      backgroundColor: primaryColor,
      expandedHeight: 500, //최대 늘어날 수 있는 값 설정
      flexibleSpace: FlexibleSpaceBar( //스크롤을 올리면 아이콘이 사라지는 공간
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight),//컨테이너 밖. safearea와의 간격을 조정해줌
            //패딩: 컨테이너 내부를 조정, KToolBarHeight: 변수이며 앱바 높이를 알려줌
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(DateTime.now().toString(),
                  style: ts.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  'asset/img/mediocre.png',
                  //미디어쿼리:현재 기기의. of(context)콘텐츠를 구성하는 size.width가로 사이즈의 /2 절반
                  width: MediaQuery.of(context).size.width/2,
                ),
                Text(
                    '보통',
                    style: ts.copyWith(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w700
                    )
                ),
                const SizedBox(height: 8.0,),
                Text(
                    '나쁘지 않네요',
                    style: ts.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
