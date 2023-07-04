import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget{
  final String imagePath;
  final String name;

  const CategoryWidget({super.key, required this.imagePath, required this.name});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromARGB(255, 197, 196, 192),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            SizedBox(
              child: Image.network(imagePath)),
            SizedBox(child: Center(child: Text(name),)),
          ],
        ),
      ),
    );
  }

}