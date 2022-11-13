import 'package:calender/Screen/component/customtext_field.dart';
import 'package:calender/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset=MediaQuery.of(context).viewInsets.bottom; //시스템적 ui로 인해 가려진 크기

    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode()); //포커스옮기기(키보드 on->off로/다음 textfield로
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,//색상
          height: MediaQuery.of(context).size.height/2+bottomInset,//높이=(전체사이즈/2)
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(),
                  SizedBox(height: 16,),
                  _content(),
                  SizedBox(height: 16,),
                  _ColorPicker(),
                  SizedBox(height: 8,),
                  _SaveButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(child: CustomTextField(label: '시작 시간',isTime: true,)),
        SizedBox(width: 16,),
        Expanded(child: CustomTextField(label: '마감 시간',isTime: true,)),
      ],
    );
  }
}

class _content extends StatelessWidget {
  const _content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomTextField(
          label: '내용',isTime: false,
        ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap( //자동줄바꿈을 지원해주는 Row같은 위젯
      spacing: 8, //각각의 childern사이의 간격 지정(가로로)
      runSpacing: 0, //위아래 children간격지정
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                primary: PRIMARY_COLOR,
              ),
              child: Text("저장")),
        ),
      ],
    );
  }
}
