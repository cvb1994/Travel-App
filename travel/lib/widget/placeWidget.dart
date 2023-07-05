import 'package:flutter/material.dart';

class PlaceWidget extends StatelessWidget{
  final String imagePath;
  final String name;
  final String location;
  final double rate;

  const PlaceWidget({super.key, required this.imagePath, required this.name, required this.location, required this.rate});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage("assets/image/place1.jpg"),fit: BoxFit.cover)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Nhon Ly"),
              Text("Quy Nhon")
            ]),
        )
      ),
    );
  }

}