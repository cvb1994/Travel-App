import 'dart:async';

import 'package:flutter/material.dart';

class CustomNotify {
  final BuildContext context;
  late Timer _timer;

  CustomNotify(this.context);

  void showNotify(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(message),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 157, 149, 149),
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 50),
    ));
  }

  void showCustomDialog(String message) {
    
    
    showGeneralDialog(
      context: context,
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        _timer = Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        
        return Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(message),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
          ),
        );
      },
    ).then((val){
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }
}
