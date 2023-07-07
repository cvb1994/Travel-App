import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/widget/package_booking.dart';
import 'package:travel/widget/placeWidget.dart';

class PlaceDetailPage extends StatefulWidget {
  static const routerName = "/placeDetail";
  final PlaceModelDto dto;
  const PlaceDetailPage({super.key, required this.dto});

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage> {
  late Future<List<CategoryModel>> futureListCategory;
  late Future<PlaceModel> futurePlace;
  
  @override
  void initState() {
    // TODO: implement initState
    futureListCategory = context.read<CategoryProvider>().getCategories();
    futurePlace = context.read<PlaceProvider>().getPlace(widget.dto.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar.withTitleFunc(funcType: AppBarFuncENum.FAV, title: widget.dto.name,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth, vertical: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 220,
              child: FutureBuilder(
                future: futurePlace,
                builder: ((context, snapshot) {
                  PlaceModel place = snapshot.data!;
                  return PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,);
                }),
              )
              //child: PlaceWidget(imagePath: place.image!, name:  place.name!, location:  place.location!, rate:  place.rate!, width: double.infinity,),
            ),
            const SubRowMenu(name: "What's Included", buttonName: "",),
            SizedBox(
              height: 70,
              child: FutureBuilder(
                future: futureListCategory,
                builder: ((context, snapshot) {
                  List<CategoryModel> categories = snapshot.data!;
                  return ListView.separated(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      CategoryModel model = categories[index];
                      return CategoryWidget(name: model.name!, imagePath: model.image!,);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    )
                  );
                }),
              )
            ),
            const SubRowMenu(name: "About Trip", buttonName: "",),
            Container(
              child: FutureBuilder(
                future: futurePlace,
                builder: ((context, snapshot) {
                  PlaceModel place = snapshot.data!;
                  return Text(place.des!);
                }),
              ),
            ),
            const SubRowMenu(name: "Gallery Photo", buttonName: "",),
            const SubRowMenu(name: "Location", buttonName: "",),
            
          ],
        ),
      ),
    );
  }
}

class SubRowMenu extends StatelessWidget{
  final String name;
  final String buttonName;

  const SubRowMenu({super.key, required this.name, required this.buttonName});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name, 
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            )
          ),
          Expanded(
            child: Text(
              buttonName, 
              style: const  TextStyle(
                color: Color.fromARGB(255, 177, 173, 173),
                fontSize: 15,
              ), 
              textAlign: TextAlign.right,
            )
          )
        ],
      ),
    );
  }
}
