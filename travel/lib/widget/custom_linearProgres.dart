import 'package:flutter/material.dart';

class CustomLinearProgess extends StatelessWidget {
  const CustomLinearProgess({super.key, required this.totalStep, required this.currentStep});

  final int totalStep;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    double fixedWidth = MediaQuery.of(context).size.width / totalStep;
    return SizedBox(
      height: 3,
      child: Row(
        children: List.generate(totalStep, (index) => Container(
          width: fixedWidth,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1,style: BorderStyle.solid),
            color: index + 1 <= currentStep ? Color.fromARGB(255, 88, 88, 87) : Color.fromARGB(0, 255, 255, 255)
          ),
        )),
      )
    );
  }

}