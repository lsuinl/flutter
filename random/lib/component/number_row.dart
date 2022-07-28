import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
 final int number;
//repactor(공통이름바꾸기 /쉬프트+f6 짱!!
  const NumberRow({required this.number,
 Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: number
          .toString()
          .split('')
          .map(
            (e) => Image.asset(
          'asset/img/$e.png',
          width: 50,
          height: 70,
        ),
      )
          .toList(),
    );
  }
}
