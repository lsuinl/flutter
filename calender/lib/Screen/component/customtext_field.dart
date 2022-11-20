import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final bool isTime; //true-시간, false-내용

  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.onSaved,
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
    return TextFormField(
      //form =input 값 동시 관리하기
      // onChanged: (String val){//입력된 문자열 값 받아오기
      //
      // },
      onSaved: onSaved,
      validator: (String? val){
        //null->에러x,에러가있으면 에러를 String로 반환
        if(val==null||val.isEmpty){
          return "값을 입력해주세요";
        }
        if(isTime){
          int time= int.parse(val);
          if(time<0){
            return '0 이상의 숫자를 입력해주세요';
          }
          if(time>24){
            return '24 이하의 숫자를 입력해주세요';
          }
        }

        return null;
      },
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

