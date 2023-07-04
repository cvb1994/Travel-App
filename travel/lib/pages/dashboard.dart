import 'package:flutter/material.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/widget/custom_navigation.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/form_input_search.dart';

class Dashboard extends StatefulWidget {
  static const routerName = "/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = TextEditingController();

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
          ],
        ),
      ),
    );
  }
}
