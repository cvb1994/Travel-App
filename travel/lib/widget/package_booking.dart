import 'package:flutter/material.dart';
import 'package:travel/widget/favorite_widget.dart';

class PackageBooking extends StatelessWidget{
  final String imagePath;
  final String name;
  final String describe;
  final double rate;
  final double price;
  final bool isFav;

  const PackageBooking({super.key, required this.imagePath, required this.name, required this.describe, required this.rate, required this.price, required this.isFav});
  
  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color.fromARGB(200, 185, 183, 183), width: 0.5)
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: NetworkImage(imagePath),fit: BoxFit.cover)
              ),
              width: 100,
              height: double.maxFinite,
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(height: 6,),
                      Text(
                        "\$$price",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.red
                        ),
                      ),
                      const SizedBox(height: 6,),
                      Row(
                        children: showStar(rate),
                      ),
                      const SizedBox(height: 6,),
                      Expanded(
                        child: Text(
                          describe,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 146, 142, 142)
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      child: FavoriteWidget(isActive: isFav,),
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }

}

List<Widget> showStar(double rate){
  List<Widget> listStar = [];
  for (var i = 0; i < 5; i++) {
    if(rate <= i){
      listStar.add(const Icon(Icons.star,color: Color.fromARGB(255, 185, 182, 182), size: 18,));
    } else {
      listStar.add(const Icon(Icons.star,color: Colors.yellow, size: 18,));
    }
  }
  listStar.add(const SizedBox(width: 5,));
  listStar.add(Text(rate.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  return listStar;
}