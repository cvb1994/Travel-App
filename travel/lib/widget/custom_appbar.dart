import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/favorite_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  String funcType; //phân loại appBar cho các chức năng khác nhau
  VoidCallback? onTap;
  String? placeId;

  CustomAppBar({super.key, required this.funcType}) {
    title = null;
    onTap = null;
  }

  CustomAppBar.withTitle({super.key, required this.funcType, this.title});

  CustomAppBar.withFunc({super.key, required this.funcType, this.onTap});

  CustomAppBar.withTitleFunc(
      {super.key, required this.funcType, this.onTap, required this.title, this.placeId});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? username;
  bool isActive = false;

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
    void addFav(){
      context.read<AuthProvider>().addUserFavorite(widget.placeId!);
    }

    void removeFav(){
      context.read<AuthProvider>().removeUserFavorite(widget.placeId!);
    }
    
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
                child: Text(username ?? "", style: TextStyle(color: Colors.black),),
              ),
              SizedBox(
                width: rightIconWidth,
                child: Icon(Icons.notifications_on),
              ),
            ],
          ));

    } else if((widget.funcType == AppBarFuncENum.FAV) ){
      return Padding(
        padding: EdgeInsets.only(
            left: paddingSizeWidth, right: paddingSizeWidth, top: 50),
        child: Row(
          children: [
            SizedBox(
              width: leftIconWidth,
              child: IconButton(
                color: Colors.black,
                onPressed: widget.onTap ??
                    () {
                      Navigator.of(context).pop();
                    },
                icon: const Icon(Icons.arrow_back_outlined
              )),
            ),
            SizedBox(
              width: titleWidth,
              child: Center(child: Text(widget.title!, style: TextStyle(color: Colors.black))),
            ),
            SizedBox(
              width: rightIconWidth,
              //child: Icon(Icons.favorite_border, color: Colors.red,),
              child: GestureDetector(
                onTap: () {
                  if(isActive){
                    removeFav();
                  } else {
                    addFav();
                  }
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: FavoriteWidget(isActive: isActive,)),
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

