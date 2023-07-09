import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/place_detail_page.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';
import 'package:travel/widget/package_booking.dart';
import 'package:travel/widget/placeWidget.dart';

class Dashboard extends StatefulWidget {
  static const routerName = "/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = TextEditingController();
  final categoryProvider = CategoryProvider();
  late Future<List<CategoryModel>> futureListCategory;
  List<CategoryWidget> list = [];
  
  final placeProvider = PlaceProvider();
  late Future<List<PlaceModel>> futureListPlace;

  @override
  void initState() {
    // TODO: implement initState
    futureListCategory = context.read<CategoryProvider>().getCategories();
    futureListPlace = context.read<PlaceProvider>().getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: CustomAppBar(funcType: AppBarFuncENum.DASHBOARD),
      bottomNavigationBar: const CustomNavigationBar(
        currentRouteName: Dashboard.routerName,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth, vertical: 15),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 20),
              child: Text(
                "Where do you \nwant to explore today?",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            InputSearch(controller: controller),
            const SubRowMenu(name: "Choose Category", buttonName: "See All",),
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
            const SubRowMenu(name: "Favorite Place", buttonName: "Explore",),
            SizedBox(
              height: 250,
              child: FutureBuilder(
                future: futureListPlace,
                builder: ((context, snapshot) {
                  List<PlaceModel> places = snapshot.data!;
                  return ListView.separated(
                    itemCount: places.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: (){

                          Navigator.of(context).pushNamed(PlaceDetailPage.routerName, arguments: places[index]);
                        },
                        child: PlaceWidget(
                          imagePath: places[index].image!, 
                          name: places[index].name!, 
                          location: places[index].location!, 
                          rate: places[index].rate!, 
                          width: 210,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    )
                  );
                }),
              )
            ),
            const SubRowMenu(name: "Popular Package", buttonName: "See All",),
            SizedBox(
              child: PackageBooking(imagePath: "f2", name: "sdv", describe: "this a paragraph for testing width of text display on screen a little longer than older", rate: 2, price: 149.99,)
            ),

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
