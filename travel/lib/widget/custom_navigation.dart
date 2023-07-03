import 'package:flutter/material.dart';
import 'package:travel/pages/favorite_page.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/pages/profile_page.dart';

class CustomNavigationBar extends StatelessWidget{
  final String currentRouteName;
  const CustomNavigationBar({super.key, required this.currentRouteName});

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;


    final List<NavigationItem> list = [];
    list.add(NavigationItem(
      iconAsset: "assets/icons/home.png", 
      routeWidgetName: Dashboard.routerName, 
      title: "Home",
      isActive: currentRouteName == Dashboard.routerName ? true : false,
    ));

    list.add(NavigationItem(
      iconAsset: "assets/icons/heart.png", 
      routeWidgetName: FavoritePage.routerName, 
      title: "Favorite",
      isActive: currentRouteName == FavoritePage.routerName ? true : false,
    ));

    list.add(NavigationItem(
      iconAsset: "assets/icons/profile.png", 
      routeWidgetName: ProfilePage.routerName, 
      title: "Profile",
      isActive: currentRouteName == ProfilePage.routerName ? true : false,
    ));

    return Padding(
      padding: EdgeInsetsDirectional.only(start: paddingSizeWidth, end : paddingSizeWidth, bottom: 15),
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: list
        ),
      ));
  }

}

class NavigationItem extends StatelessWidget{
  const NavigationItem({super.key, required this.routeWidgetName, required this.iconAsset, required this.isActive, required this.title});
  final String routeWidgetName;
  final String title;
  final String iconAsset;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return isActive ? 
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Image(
                image: AssetImage(iconAsset), 
                color: Colors.white,
                width: 50,
                
              ),
              SizedBox(width: 10,),
              Text(
                title, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20),
              ),
            ],
          )
        )
      )
      : Padding(padding: EdgeInsetsDirectional.only(start: 50),
       child: Image(image: AssetImage(iconAsset)));
  }

}