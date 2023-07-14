import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/place_detail_page.dart';
import 'package:travel/provider/place_provider.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/package_booking.dart';

class FavoritePage extends StatefulWidget {
  static const routerName = "/favorite";
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<PlaceModel> listPlace;
  int countCompleted = 0;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  void fetchData() async {
    listPlace = await context
        .read<PlaceProvider>()
        .getFavoritePlaces()
        .whenComplete(() {
      setState(() {
        countCompleted++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;

    if (countCompleted < 1) {
      EasyLoading.show(status: 'loading...');
      return Container();
    }

    EasyLoading.dismiss();

    return Scaffold(
      bottomNavigationBar: const CustomNavigationBar(
        currentRouteName: FavoritePage.routerName,
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSizeWidth),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.symmetric(vertical: 10),
              child: Text(
                "Your Wishlist",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                itemCount: listPlace.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            PlaceDetailPage.routerName,
                            arguments: listPlace[index]);
                      },
                      child: SizedBox(
                          child: PackageBooking(
                        imagePath: listPlace[index].image!,
                        name: listPlace[index].name!,
                        describe: listPlace[index].des!,
                        rate: listPlace[index].rate!,
                        price: listPlace[index].price!,
                        isFav: listPlace[index].isFav!,
                      )));
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    )),
          ],
        ),
      ),
    );
  }
}
