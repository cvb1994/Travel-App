import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.title,
      required this.func,
      required this.color});
  final VoidCallback func;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: Color.fromARGB(249, 133, 129, 129)),
            color: color),
        padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20)),
        ),
      ),
    );
  }
}
