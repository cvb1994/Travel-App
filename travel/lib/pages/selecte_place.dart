import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/custom_button.dart';

import 'package:travel/widget/custom_selectWidget.dart';

class SelectPlaceScreen extends StatelessWidget {
  const SelectPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.height * 0.15;
    double infoSize = MediaQuery.of(context).size.height * 0.7;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    List<WidgetSelect> listSelect = [];
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/beach.png",
      title: "Beach",
      isSelected: false,
    ));
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/camping.png",
      title: "camping",
      isSelected: false,
    ));
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/fishing.png",
      title: "Fishing",
      isSelected: false,
    ));
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/forest.png",
      title: "Forest",
      isSelected: false,
    ));
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/moutain.png",
      title: "Moutain",
      isSelected: false,
    ));
    listSelect.add(WidgetSelect(
      imagePath: "assets/icons/ocean.png",
      title: "Ocean",
      isSelected: false,
    ));

    void onTap() {
      EasyLoading.show(status: 'loading...');
      List<String> places = [];
      listSelect.forEach((element) {
        if (element.isSelected) {
          {
            places.add(element.title);
          }
        }
      });

      Future? resp = context.read<AuthProvider>().updateUserInterest(places);
      resp.then((value) {
        ResponseModel respDto = value;
        if (respDto.responseCode == ResponseCodeEnum.SUCCESS) {
          EasyLoading.dismiss();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Dashboard()));
        } else {
          EasyLoading.dismiss();
        }
      }).catchError((e) {
        EasyLoading.dismiss();
      });

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      // );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsetsDirectional.only(
              start: paddingSizeWidth, end: paddingSizeWidth),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: textSize,
                child: const Padding(
                  padding: EdgeInsetsDirectional.only(top: 15),
                  child: Center(
                      child: Text(
                    "Where is your favorite place to explore?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        height: 1.2,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5),
                  )),
                ),
              ),
              SizedBox(
                  height: infoSize,
                  child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 30,
                      crossAxisCount: 2,
                      children: listSelect)),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomButton(
                  title: "Next",
                  func: onTap,
                  color: Colors.amber,
                ),
              )
            ],
          ),
        ));
  }
}
