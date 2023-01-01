import 'package:dusty_dust/const/colors.dart';
import 'package:flutter/material.dart';

class Card_Title extends StatelessWidget {
  final String title;

  const Card_Title({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: dartColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
