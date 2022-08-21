import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideoPressed,
    Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false;

  @override
  void initState() { //async xw사용불가
    super.initState();

    initialzController();
  }

  @override //영상을 변경하면 다른 영상을 불러올수이도록 init
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.video.path != widget.video.path){
      initialzController();
    }
  }


  initialzController() async{
    currentPosition = Duration(); //머선에러수정

    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController!.initialize();

    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;

      setState((){
        this.currentPosition=currentPosition;
      });
    });

    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    if(videoController == null){
      return CircularProgressIndicator();
    }
    return AspectRatio(
      aspectRatio:videoController!.value.aspectRatio, //영상의 비율
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(
                videoController!
            ),
            if(showControls) //터치하면 보이게

            _Controls(
              onReversePressed: onReversePressed,
              onPlayPressed: onPlayPressed,
              onForwardPressed: onForwardPressed,
              isPlaying: videoController!.value.isPlaying,
            ),
            if(showControls)
            _Newvideo(
              onPressed: widget.onNewVideoPressed,
            ),
            _Sliderbottom(
                currentPosition: currentPosition,
                maxPosition: videoController!.value.duration,
                onSliderChanged: onSliderChanged,
            ),
          ],
        ),
      ),
    );
  }

  void onSliderChanged(double val){
    (double val){
      videoController!.seekTo(
        Duration(
          seconds: val.toInt(),
        ),
      );
    };
  }

  void onReversePressed(){
    final currentPosition = videoController!.value.position;

    Duration position = Duration();

    if(currentPosition.inSeconds >3) {
      Duration position = currentPosition - Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onForwardPressed(){
    final maxposition= videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxposition;

    if((maxposition -Duration(seconds: 3)).inSeconds< currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onPlayPressed(){

    setState((){
      if(videoController!.value.isPlaying){
        videoController!.pause();
      }
      else{
        videoController!.play();
      }
    });
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls({
    required this.onPlayPressed,
    required this.onReversePressed,
    required this.onForwardPressed,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          )
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      color: Colors.white,
      iconSize: 30,
      icon: Icon(
        iconData,
      ),
    );
  }
}
class _Newvideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _Newvideo({
    required this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );;
  }
}

class _Sliderbottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _Sliderbottom({
    required this.currentPosition,
    required this.maxPosition,
    required this.onSliderChanged,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes} : ${(currentPosition.inSeconds % 60).toString().padLeft(2,'0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                max: maxPosition.inSeconds.toDouble(),
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              '${maxPosition.inMinutes} : ${(maxPosition.inSeconds % 60).toString().padLeft(2,'0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
