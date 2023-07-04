import 'package:flutter/material.dart';
import 'package:travel/widget/custom_navigation.dart';

class FavoritePage extends StatefulWidget {
  static const routerName = "/favorite";
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Favorite")),
      bottomNavigationBar:
          CustomNavigationBar(currentRouteName: FavoritePage.routerName),
    );
  }
}
