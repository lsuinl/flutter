import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vodio_player/component/custom_vidio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? vidio;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: vidio == null ?  RenderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo(){
    return Center(
      child: CustomVideoPlayer(
        video: vidio!,
        onNewVideoPressed: onNewVideoPressed ,
      ),
    );
  }

Widget RenderEmpty(){
   return Container(
    width: MediaQuery.of(context).size.width,
    decoration: getboxDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Logo(
          onTap: onNewVideoPressed,
        ),
        SizedBox(height: 30),
        _AppName(),
      ],
    ),
  );
}
void onNewVideoPressed() async{
    final vidio = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if(vidio != null){
      setState((){
        this.vidio = vidio;
      });
    }
}

  BoxDecoration getboxDecoration(){
    return BoxDecoration( //color과 중복사용 불가. 하위에 컬러넣기는 가능)
      gradient: LinearGradient( //일괄적 그라데이션(Redial:가운데부터 그라데이션)
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
  Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      GestureDetector(
        onTap: onTap,
        child: Image.asset(
        'asset/image/logo.png',
    ),
      );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textstyle=TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w300,
    );

    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textstyle,
        ),
        Text(
            'PLAYER',
            style: textstyle.copyWith(fontWeight: FontWeight.w700,)
        ),
      ],
    );
  }
}
