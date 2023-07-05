import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';
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
  
  @override
  void initState() {
    // TODO: implement initState
    var read = context.read<CategoryProvider>();
    futureListCategory = read.getCategories();
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
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
        child: Column(
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
                future: futureListCategory,
                builder: ((context, snapshot) {
                  List<CategoryModel> categories = snapshot.data!;
                  return ListView.separated(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index){
                      return PlaceWidget(imagePath: "f2", name: "sdv", location: "sdf", rate: 2,);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15,
                    )
                  );
                }),
              )
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
                fontSize: 23,
                fontWeight: FontWeight.bold
              )
            )
          ),
          Expanded(
            child: Text(
              buttonName, 
              style: const  TextStyle(
                color: Color.fromARGB(255, 177, 173, 173),
                fontSize: 23,
              ), 
              textAlign: TextAlign.right,
            )
          )
        ],
      ),
    );
  }
}
