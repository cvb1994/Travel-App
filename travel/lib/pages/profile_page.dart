import 'package:flutter/material.dart';
import 'package:travel/widget/custom_navigation.dart';

class ProfilePage extends StatefulWidget {
  static const routerName = "/profile";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    String routeName = ModalRoute.of(context)!.settings.name!;
    return Scaffold(
      body: Center(child: Text("Profile")),
      bottomNavigationBar: CustomNavigationBar(currentRouteName: routeName),
    );
  }

}