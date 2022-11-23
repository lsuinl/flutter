import 'package:calender/Screen/component/customtext_field.dart';
import 'package:calender/const/colors.dart';
import 'package:calender/database/drift_database.dart';
import 'package:calender/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calender/database/drift_database.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formkey=GlobalKey(); //우엥?

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

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
              child: Form(//묶어서 텍스트입력관히라기
                key: formkey, //form의 컨트롤러같은 존재
                autovalidateMode: AutovalidateMode.always, //자동검증
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val){
                        startTime=int.parse(val!);
                      },
                      onEndSaved: (String? val){
                        endTime=int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16,),
                    _content(
                      onSaved: (String? val){
                        content=val;
                      },
                    ),
                    SizedBox(height: 16,),
                    FutureBuilder<List<CategoryColor>>(
                      future: GetIt.I<LocalDatabase>().getCategoryColors(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData &&
                            selectedColorId==null
                            &&snapshot.data!.isNotEmpty){
                          selectedColorId=snapshot.data![0].id;
                        }
                        return _ColorPicker(
                          selectedColorId: selectedColorId!,
                          colorIdSetter: (int id){
                            setState(() {
                              selectedColorId=id;
                            });
                          },
                          colors:snapshot.hasData ?
                            snapshot.data!
                            : [],);
                      }
                    ),
                    SizedBox(height: 8,),
                    _SaveButton(onPressed: onSavePressed,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed(){ //입력 검증 및 저장하기
    //폼키는 생성했지만 폼위젯과 결합하지 못한 경우
    if(formkey.currentState==null){
      return;
    }
    if(formkey.currentState!.validate()){ //validata=>모든 텍스트폼필드의 vaildate함수 실행
      print("no error");
      formkey.currentState!.save(); //저장
    }
    else{ //어느 하나라도 에러 발생되어 vaild에 string 반환될경우
      print("error");
    }

  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({
    required this.onStartSaved,
    required this.onEndSaved,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      children: [
        Expanded(child: CustomTextField(label: '시작 시간',isTime: true,onSaved: onStartSaved,)),
        SizedBox(width: 16,),
        Expanded(child: CustomTextField(label: '마감 시간',isTime: true, onSaved: onEndSaved,)),
      ],
    );
  }
}

class _content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _content({
    required this.onSaved,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomTextField(
          label: '내용',isTime: false,
          onSaved: onSaved,
        ),
    );
  }
}

typedef ColorIdSetter =void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap( //자동줄바꿈을 지원해주는 Row같은 위젯
      spacing: 8, //각각의 childern사이의 간격 지정(가로로)
      runSpacing: 0, //위아래 children간격지정
      children: colors.map(
            (e) => GestureDetector(
              onTap: (){
                colorIdSetter(e.id);
              },
              child: renderColor(e,selectedColorId==e.id),
            ),
    ).toList(),
    ); //선택체크
  }

  Widget renderColor(CategoryColor color, bool isSelected){
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(int.parse('${color.hexCode}', radix: 16)),
        border: isSelected? Border.all(color: Colors.black, width: 4):null //선택되었을 떄 실행
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: PRIMARY_COLOR,
              ),
              child: Text("저장")),
        ),
      ],
    );
  }
}
