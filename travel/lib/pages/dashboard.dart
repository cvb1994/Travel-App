import 'package:flutter/material.dart';
import 'package:travel/widget/custom_navigation.dart';

class Dashboard extends StatefulWidget {
  static const routerName = "/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Hi Friends")),
      bottomNavigationBar: CustomNavigationBar(currentRouteName: Dashboard.routerName,),
    );
  }

}