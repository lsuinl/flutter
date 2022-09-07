import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolcheckdone =  false; //출근여부확인

  //latitude -위도, longitude-경도
  //위치 기능
  static final LatLng companyLatlng = LatLng(
    37.5233273,
    126.921252,
  );
  static final double okdistance = 100;
  static final Circle withinDistanceCircle = Circle(
    circleId:
        CircleId('withinDistanceCircle'), //여러개의 동그라미를 그렸을 때의 동그라미를 구분하는 데 사용
    center: companyLatlng,
    fillColor: Colors.blue.withOpacity(0.5), //색채우기
    radius: okdistance, //반지름, 반경
    strokeColor: Colors.blue.withOpacity(0.5), //테두리둘레색
    strokeWidth: 1,
  );
  static final Circle notwithinDistanceCircle = Circle(
    circleId:
        CircleId('notwithinDistanceCircle'), //여러개의 동그라미를 그렸을 때의 동그라미를 구분하는 데 사용
    center: companyLatlng,
    fillColor: Colors.red.withOpacity(0.5), //색채우기
    radius: okdistance, //반지름, 반경
    strokeColor: Colors.red.withOpacity(0.5), //테두리둘레색
    strokeWidth: 1,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'), //여러개의 동그라미를 그렸을 때의 동그라미를 구분하는 데 사용
    center: companyLatlng,
    fillColor: Colors.green.withOpacity(0.5), //색채우기
    radius: okdistance, //반지름, 반경
    strokeColor: Colors.green.withOpacity(0.5), //테두리둘레색
    strokeWidth: 1,
  );
  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLatlng,
  );
  //줌 레벨(확대된 정도)설정, 초기위치.설정
  static final CameraPosition initionlposition = CameraPosition(
    target: companyLatlng,
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data == '위치 권한이 허가되었습니다.') {
              return StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    bool isWithinRange = false; //원 안에 내 위치가 존재하는지의 여부

                    if (snapshot.hasData) {
                      final start = snapshot.data!;
                      final end = companyLatlng; //현재 회사의 위치.
                      //start와 end 둘 사이의 거리가 100m 미만이 맞는지 확인.

                      final distance = Geolocator.distanceBetween(
                        start.latitude,
                        start.longitude,
                        end.latitude,
                        end.longitude,
                      );

                      if (distance < okdistance) {
                        isWithinRange = true;
                      }
                    }

                    return Column(
                      children: [
                        _CustomGoogleMap(
                          marker: marker,
                          circle: choolcheckdone ?
                          checkDoneCircle :
                          isWithinRange
                              ? withinDistanceCircle
                              : notwithinDistanceCircle,
                          initialPostion: initionlposition,
                        ),
                        _ChoolCheckButton(
                          onPressed: onChoolCheckPressed,
                          isWithinRange: isWithinRange,
                          choolcheckdone: choolcheckdone,
                        ),
                      ],
                    );
                  }
                  );
            }
            return Center(
              child: Text(snapshot.data),
            );
          },
        )
    );
  }

  onChoolCheckPressed() async{
    final result = await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog( //팝업창같은 다이어로그를 쉽게 띄워주는 기능
            title: Text("출근하기"),
            content: Text("출근을 하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: Text("취소"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: Text("출근하기"),
              ),
            ],
          );
        }
    );
    if(result){
      setState((){
        choolcheckdone = true;
      });
    }
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
    if (checkPermission == LocationPermission.denied) {
      //권한을 사용할 수 없지만 요청할 수는 있는 경우
      checkPermission = await Geolocator.requestPermission();

      if (checkPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요';
      }
    }
    if (checkPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 셋팅에서 허가해주세요';
    }
    return '위치 권한이 허가되었습니다.';
  }
}

AppBar renderAppBar() {
  return AppBar(
    //타이틀
    title: Text(
      '나의 맥북 안녕',
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: Colors.white,
  );
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPostion;
  final Circle circle;
  final Marker marker;
  const _CustomGoogleMap(
      {required this.initialPostion,
      required this.circle,
      required this.marker,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GoogleMap(
        initialCameraPosition: initialPostion, //초기 카메라 위치
        myLocationEnabled: true, //내위치표시
        myLocationButtonEnabled: false, //내위치로가기버튼(커스텀할 예정)
        mapType: MapType.normal, //맵타입형식 위성지도 등등 설정 가능
        circles: Set.from([circle]),
        markers: Set.from([marker]),
      ),
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolcheckdone;
  const _ChoolCheckButton({
    required this.choolcheckdone,
    required this.isWithinRange,
    required this.onPressed,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50,
            //웬만하면 이렇게 쓰지말고 if문으로 깔끔하게 작성할 것.
            color:choolcheckdone
                ? Colors.green
                : isWithinRange
                  ? Colors.blue
                  : Colors.red,
          ),
          const SizedBox(height: 20),
          if(!choolcheckdone && isWithinRange)
            ElevatedButton(
                onPressed: onPressed,
                child: Text("출근하기"),
            ),
        ],
      ),
    );
  }
}
