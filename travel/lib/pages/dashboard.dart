import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/widget/categoryWidget.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';
import 'package:travel/provider/category_provider.dart';

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
            SizedBox(height: 20,),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "Choose Category", 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                Expanded(
                  child: Text(
                    "See all", 
                    style: TextStyle(
                      color: Color.fromARGB(255, 177, 173, 173),
                      fontSize: 23,
                    ), 
                    textAlign: TextAlign.right,
                  )
                )
              ],
            ),
            FutureBuilder(
              future: futureListCategory,
              builder: ((context, snapshot) {
                List<CategoryModel> categories = snapshot.data!;
                return ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    CategoryModel model = categories[index];
                    return CategoryWidget(name: model.name!, imagePath: model.image!,);
                  }
                );
              }),
            )
            // Row(children: [
            //   Image.network(listCategory[1].image!)
            // ],)
          ],
        ),
      ),
    );
  }
}
