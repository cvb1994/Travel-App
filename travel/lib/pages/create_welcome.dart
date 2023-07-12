import 'package:flutter/material.dart';
import 'package:travel/pages/selecte_place.dart';
import 'package:travel/widget/custom_button.dart';

class CreatedWelcomeScreen extends StatelessWidget {
  const CreatedWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectPlaceScreen()),
      );
    }

    double iconSize = MediaQuery.of(context).size.height * 0.5;
    double infoSize = MediaQuery.of(context).size.height * 0.4;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
        body: Padding(
      padding: EdgeInsetsDirectional.only(
          start: paddingSizeWidth, end: paddingSizeWidth),
      child: Column(
        children: [
          SizedBox(
            height: iconSize,
            child: const Icon(
              Icons.place_rounded,
              color: Colors.amber,
              size: 150,
            ),
          ),
          SizedBox(
              height: infoSize,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Successfully created an account",
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                        "After this, you can explore any place you want. Enjoy it",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 95, 95),
                            fontWeight: FontWeight.normal,
                            height: 1.5)),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              title: "Let's Explore!",
              func: onTap,
              color: Colors.amber,
            ),
          )
        ],
      ),
    ));
  }
}
