import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget{
  final String imagePath;
  final String name;

  const CategoryWidget({super.key, required this.imagePath, required this.name});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(118, 233, 232, 229),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Image.network(imagePath)),
            Expanded(
              child: Center(child: Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),)),
          ],
        ),
      ),
    );
  }

}