import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
// 권한과 관련된 모든 값은 미래의 값을 받아오는 async로 작업
  Future<String> checkPermission() async {
    //권한을 사용할 수 있는지를 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화 해주세요.';
    }
    //현재 앱이 가지고 있는 위치서비스에 대한 권한 값을 location이라는 형식으로 반환
    LocationPermission checkPermission = await Geolocator.checkPermission();
    if (checkPermission ==
        LocationPermission.denied) { //권한을 사용할 수 없지만 요청할 수는 있는 경우
      checkPermission = await Geolocator.requestPermission();

      if (checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요';
      }
    }
      if (checkPermission == LocationPermission.deniedForever) {
        return '앱의 위치 권한을 셋팅에서 허가해주세요';
      }
      return '위치 권한을 허가되었습니다.';
    }
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
