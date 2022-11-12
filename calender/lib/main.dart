import 'package:calender/Screen/component/calender.dart';
import 'package:flutter/material.dart';

import 'Screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    )
  );
}
