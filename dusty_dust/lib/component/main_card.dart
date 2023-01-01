import 'package:flutter/material.dart';

import '../const/colors.dart';

class Main_Card extends StatelessWidget {
  final Widget child;

  const Main_Card({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(
            //양쪽 동시적용
            horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular((16))),
        ), //테?두리
        color: lightColor,
        child: child);
  }
}
