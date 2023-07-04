import 'package:flutter/material.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  String funcType; //phân loại appBar cho các chức năng khác nhau
  VoidCallback? onTap;

  CustomAppBar({super.key, required this.funcType}) {
    title = null;
    onTap = null;
  }

  CustomAppBar.withTitle({super.key, required this.funcType, this.title});

  CustomAppBar.withFunc({super.key, required this.funcType, this.onTap});

  CustomAppBar.withTitleFunc(
      {super.key, required this.funcType, this.onTap, this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? username;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString("userName") ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.05;
    double leftIconWidth = (MediaQuery.of(context).size.width * 0.9) * 0.1;
    double titleWidth = (MediaQuery.of(context).size.width * 0.9) * 0.8;
    double rightIconWidth = (MediaQuery.of(context).size.width * 0.9) * 0.1;

    if (widget.funcType == AppBarFuncENum.DASHBOARD) {
      return Padding(
          padding: EdgeInsets.only(
              left: paddingSizeWidth, right: paddingSizeWidth, top: 50),
          child: Row(
            children: [
              SizedBox(
                width: leftIconWidth,
                child: Image.asset(
                  "assets/icons/profile.png",
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(
                width: titleWidth,
                child: Text(username ?? ""),
              ),
              SizedBox(
                width: rightIconWidth,
                child: Icon(Icons.notifications_on),
              ),
            ],
          ));
    } else {
      return AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
            color: Colors.black,
            onPressed: widget.onTap ??
                () {
                  Navigator.of(context).pop();
                },
            icon: const Icon(Icons.arrow_back_outlined)),
      );
    }
  }
}
