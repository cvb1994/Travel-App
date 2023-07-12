import 'package:flutter/material.dart';
import 'package:travel/pages/favorite_page.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/pages/profile/profile_page.dart';

class CustomNavigationBar extends StatelessWidget {
  final String currentRouteName;
  const CustomNavigationBar({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;
    double itemSize = (MediaQuery.of(context).size.width * 0.8) / 4;

    final List<NavigationItem> list = [];
    list.add(NavigationItem(
      iconAsset: "assets/icons/home.png",
      routeWidgetName: Dashboard.routerName,
      title: "Home",
      isActive: currentRouteName == Dashboard.routerName ? true : false,
      width: itemSize,
    ));

    list.add(NavigationItem(
      iconAsset: "assets/icons/heart.png",
      routeWidgetName: FavoritePage.routerName,
      title: "Favorite",
      isActive: currentRouteName == FavoritePage.routerName ? true : false,
      width: itemSize,
    ));

    list.add(NavigationItem(
      iconAsset: "assets/icons/profile.png",
      routeWidgetName: ProfilePage.routerName,
      title: "Profile",
      isActive: currentRouteName == ProfilePage.routerName ? true : false,
      width: itemSize,
    ));

    return Padding(
        padding: EdgeInsetsDirectional.only(
            start: paddingSizeWidth, end: paddingSizeWidth, bottom: 15),
        child: SizedBox(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.start, children: list),
        ));
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.routeWidgetName,
    required this.iconAsset,
    required this.isActive,
    required this.title,
    required this.width,
  });
  final String routeWidgetName;
  final String title;
  final String iconAsset;
  final bool isActive;
  final double width;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? GestureDetector(
            child: Container(
                width: width * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black,
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(iconAsset),
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ))),
          )
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(routeWidgetName);
            },
            child: SizedBox(
              width: width,
              child: Image(image: AssetImage(iconAsset)),
            ),
          );
  }
}
