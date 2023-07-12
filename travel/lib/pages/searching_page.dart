import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/SubMenuWidget.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/widget/gallery_widget.dart';
import 'package:travel/widget/package_booking.dart';
import 'package:travel/widget/placeWidget.dart';

class SearchingPage extends StatefulWidget {
  static const routerName = "/searchingPage";
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  late Future<PlaceModel> futurePlace;
  final controller = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar.withTitle(funcType: AppBarFuncENum.OTHER, title: "Search"),
      body: Padding(
        padding: EdgeInsets.all(10), 
        child: Column(
          children: [
            InputSearch(controller: controller, isEnable: true,),
          ],
        )),
    );
  }
}

