import 'package:flutter/material.dart';

class SubRowMenu extends StatelessWidget{
  final String name;
  final String buttonName;

  const SubRowMenu({super.key, required this.name, required this.buttonName});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name, 
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            )
          ),
          Expanded(
            child: Text(
              buttonName, 
              style: const  TextStyle(
                color: Color.fromARGB(255, 177, 173, 173),
                fontSize: 15,
              ), 
              textAlign: TextAlign.right,
            )
          )
        ],
      ),
    );
  }
}