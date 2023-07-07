import 'package:flutter/material.dart';
import 'package:travel/widget/custom_button.dart';

import 'package:travel/pages/auth/login_page.dart';
import 'package:travel/widget/gallery_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      Navigator.push(
        context,
        //MaterialPageRoute(builder: (context) => LoginPage()),
        MaterialPageRoute(builder: (context) => GalleryWidget(placeId: "-NZgLmcdyu2L8UJlUoqC")),
      );
    }

    double infoSize = MediaQuery.of(context).size.height * 0.9;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;
    double paddingSizeHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/welcome_wallpaper.jpg"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  start: paddingSizeWidth, end: paddingSizeWidth),
              child: Column(
                children: [
                  SizedBox(
                    height: infoSize,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: paddingSizeHeight),
                      child: Column(
                        children: const [
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text("Travel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text("Lets Explore The World",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 55)),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: Text(
                                "Lets explore the world with us with just a few click",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      title: "Next",
                      func: onTap,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            )));
  }
}
