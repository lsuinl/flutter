import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime; //true-시간, false-내용
  const CustomTextField({
    required this.label,
    required this.isTime,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //시작정
      children: [
        Text(label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField()),//공간차지..
      ],
    );
  }
  Widget renderTextField(){
    return TextField(
      maxLines: isTime ? 1: null,//줄바꿈 개수 제한(null==무한)
      expands: !isTime, //세로로 최대한으로 늘림,
      keyboardType: isTime ? TextInputType.number: TextInputType.multiline, //열리는키보드의 타입=숫자
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly//숫자만 입력가능
      ]:[],
      cursorColor:Colors.grey, //커서색 변경,
      decoration: InputDecoration(
        border: InputBorder.none, //보더 없애기(줄?)
        filled: true, //색 변경 가능하도록 설정
        fillColor: Colors.grey[300],
      ),
    );
  }
}

