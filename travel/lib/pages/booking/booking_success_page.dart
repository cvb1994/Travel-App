import 'package:flutter/material.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/widget/custom_button.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.of(context).pushNamed(Dashboard.routerName);
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
            child: Image.asset("assets/icons/holiday_travel.png"),
          ),
          SizedBox(
              height: infoSize,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Booking Successfully",
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
                    child: Center(
                      child: Text(
                          "Get everything ready until it's time to go on a trip",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 97, 95, 95),
                              fontWeight: FontWeight.normal,
                              height: 1.5)),
                    ),
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
