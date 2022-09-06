import 'package:flutter/material.dart';
import 'package:random/component/number_row.dart';
import 'package:random/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;
  const SettingScreen({required this.maxNumber, Key? key,}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  double maxNumber=1000;

  //SettingScreenstate가 생성되는 순간 실행
  @override
  void initState() {
    // TODO: implement initState
    maxNumber= widget.maxNumber.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _body(maxNumber: maxNumber),
              _footer(maxNumber: maxNumber,
                onSliderChanged: onSliderChanged,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
  void onSliderChanged(double val){
      setState(() {
        maxNumber = val;
      });
    }

    void onButtonPressed(){
      Navigator.of(context).pop(maxNumber.toInt());
    }
  }

class _body extends StatelessWidget {
  final double maxNumber;
  const _body({required this.maxNumber, Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );


  }
}

class _footer extends StatelessWidget {
  final double maxNumber;
  final ValueChanged<double>? onSliderChanged;
  final VoidCallback onButtonPressed;

  const _footer({
    required this.onButtonPressed,
    required this.maxNumber,
    required this.onSliderChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          onPressed: onButtonPressed,
          child: Text('저장!'),
        ),
      ],
    );
  }
}
