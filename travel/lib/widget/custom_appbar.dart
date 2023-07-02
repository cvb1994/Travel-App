import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  bool? favExist;            //hiển thị symbol fav hay không
  bool? isFav;               //hiện thị trạng thái của fav
  VoidCallback? onTap;

  CustomAppBar({super.key}){
    title = null;
    favExist = false;
    isFav = false;
    onTap = null;
  }

  CustomAppBar.withFunc(VoidCallback this.onTap, {super.key});

  CustomAppBar.withParam(String this.title, bool this.favExist, bool this.isFav, {super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      elevation: 0,
      leading: IconButton(
        color: Colors.black,
        onPressed: widget.onTap ?? (){
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_outlined)) ,
    );
  }

}