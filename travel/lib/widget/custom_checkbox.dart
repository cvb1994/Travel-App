import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});
  

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox>{
  bool isChecked = false;

  void onChanged(bool value){
    setState(() {
        isChecked = !isChecked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.yellow,
      side: const BorderSide(
        color: Color.fromARGB(249, 133, 129, 129),
        width: 1,
        style: BorderStyle.solid
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      value: isChecked, 
      onChanged: (bool? value){
        onChanged(value!);}
    );
  }

}