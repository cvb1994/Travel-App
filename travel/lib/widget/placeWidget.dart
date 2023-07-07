import 'package:flutter/material.dart';

class PlaceWidget extends StatelessWidget{
  final String imagePath;
  final String name;
  final String location;
  final double rate;
  final double width;

  const PlaceWidget({super.key, required this.imagePath, required this.name, required this.location, required this.rate, required this.width});
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(imagePath),fit: BoxFit.cover)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const Icon(Icons.location_pin, color: Colors.white,),
                  Text(
                    location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: showStar(rate),
              )
              
            ]),
        )
      ),
    );
  }

}

List<Widget> showStar(double rate){
  List<Widget> listStar = [];
  for (var i = 0; i < 5; i++) {
    if(rate <= i){
      listStar.add(const Icon(Icons.star,color: Colors.white, size: 15,));
    } else {
      listStar.add(const Icon(Icons.star,color: Colors.yellow, size: 15,));
    }
  }
  listStar.add(const SizedBox(width: 5,));
  listStar.add(Text(rate.toString(), style: const TextStyle(color: Colors.white, fontSize: 15)));
  return listStar;
}