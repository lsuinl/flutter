import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //latitude -위도, longitude-경도
  //위치 기능
  static final LatLng companyLatlng = LatLng(
      37.5233273,
      126.921252,
  );
  //줌 레벨(확대된 정도)설정, 초기위치.설정
  static final CameraPosition initionlposition = CameraPosition(
      target: companyLatlng,
      zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:renderAppBar(),
      body:Column(
        children: [
          _CustomGoogleMap(
              initialPostion: initionlposition
          ),
          _ChoolCheckButton(),
        ],
      )
    );
  }
  AppBar renderAppBar(){
    return AppBar( //타이틀
      title: Text(
        '나의 맥북 안녕',
        style: TextStyle(
          color:Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPostion;
  const _CustomGoogleMap({required this.initialPostion,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GoogleMap(
        initialCameraPosition: initialPostion, //초기 카메라 위치
        mapType: MapType.normal, //맵타입형식 위성지도 등등 설정 가능
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  const _ChoolCheckButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text('출근'),
    );
  }
}
