import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:calling/const/agora.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  late RtcEngine? engine;
  int? uid;
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if(engine != null){
                      await engine!.leaveChannel();
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('채널 나가기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget renderSubView(){
    if(otherUid == null){
      return Center(
        child: Text('채널에 유저가 없습니다.'),
      );
    }else{
      return RtcRemoteView.SurfaceView(
        uid: otherUid!,
        channelId: CHANNEL_NAME,
      );
    }
  }

  Widget renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요.'),
      );
    } else {
      return RtcLocalView.SurfaceView();
    }
  }

  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }
    if (engine == null) {
      engine=createAgoraRtcEngine();
      await engine?.initialize(const RtcEngineContext(
        appId: 'f1f02fa11fcf43419aab4696b7f94a7a',
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ));

      engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            print('채널에 입장했습니다. uid : $uid');
            setState(() {
              this.uid = uid;
            });
          },
          onUserOffline: (RtcConnection connection, int remoteUid,UserOfflineReasonType reason) {
            print('채널 퇴장');
            setState(() {
              uid = null;
            });
          },
          onUserJoined: (RtcConnection connection,int remoteUid, int elapsed) {
            print('상대가 채널에 입장했습니다. uid : $uid');
            setState(() {
              otherUid = uid;
            });
          },
        ),
      );
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster)
      // 비디오 활성화
      await engine!.enableVideo();
      // 채널에 들어가기
      await engine?.joinChannel(
          token: TEMP_TOKEN,
          channelId: CHANNEL_NAME,
          uid: 0,
        options: ChannelMediaOptions()//뭔데
      );
    }

    return true;
  }
}