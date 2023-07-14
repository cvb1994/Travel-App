import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/model/category_model.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/place_detail_page.dart';
import 'package:travel/pages/searching_page.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/SubMenuWidget.dart';
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
  late List<CategoryModel> listCategory;
  late List<PlaceModel> listPlace;

  bool isLoading = true;
  int countCompleted = 0;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    listCategory =
        await context.read<CategoryProvider>().getCategories().whenComplete(() {
      countCompleted++;
      setState(() {});
    });
    listPlace =
        await context.read<PlaceProvider>().getPlaces().whenComplete(() {
      countCompleted++;
      setState(() {});
    });
  }

  void _refreshData() {
    print("da refresh");
    setState(() {
      countCompleted = 0;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    if (countCompleted < 2) {
      EasyLoading.show(status: 'loading...');
      return Container();
    }

    EasyLoading.dismiss();
    return Scaffold(
      appBar: CustomAppBar(funcType: AppBarFuncENum.DASHBOARD),
      bottomNavigationBar: const CustomNavigationBar(
        currentRouteName: Dashboard.routerName,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: paddingSizeWidth, vertical: 15),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 20),
              child: Text(
                "Where do you \nwant to explore today?",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(SearchingPage.routerName);
              },
              child: InputSearch(
                controller: controller,
                isEnable: false,
              ),
            ),
            const SubRowMenu(
              name: "Choose Category",
              buttonName: "See All",
            ),
            SizedBox(
                height: 70,
                child: ListView.separated(
                    itemCount: listCategory.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      CategoryModel model = listCategory[index];
                      return CategoryWidget(
                        name: model.name!,
                        imagePath: model.image!,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ))),
            const SubRowMenu(
              name: "Favorite Place",
              buttonName: "Explore",
            ),
            SizedBox(
                height: 250,
                child: ListView.separated(
                    itemCount: listPlace.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PlaceDetailPage.routerName,
                                  arguments: listPlace[index])
                              .then((_) {
                            setState(() {
                              countCompleted = 0;
                            });
                            _refreshData();
                          });
                        },
                        child: PlaceWidget(
                          imagePath: listPlace[index].image!,
                          name: listPlace[index].name!,
                          location: listPlace[index].location!,
                          rate: listPlace[index].rate!,
                          width: 210,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ))),
            const SubRowMenu(
              name: "Popular Package",
              buttonName: "See All",
            ),
            Column(
              children: gen(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> gen() {
    List<Widget> list = [];
    listPlace.forEach((element) {
      list.add(GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(PlaceDetailPage.routerName, arguments: element)
                .then((_) {
              setState(() {
                countCompleted = 0;
              });
              _refreshData();
            });
            ;
          },
          child: PackageBooking(
            imagePath: element.image!,
            name: element.name!,
            describe: element.des!,
            rate: element.rate!,
            price: element.price!,
            isFav: element.isFav!,
          )));
      list.add(const SizedBox(
        height: 20,
      ));
    });

    return list;
  }
}
