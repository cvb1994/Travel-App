import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  const CustomButton({super.key, required this.title, required this.page});
  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber
        ),
        padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                    color: Colors.black, 
                    fontWeight: FontWeight.normal,
                    fontSize: 20 )),
        ),
      ),
    );
  }

}