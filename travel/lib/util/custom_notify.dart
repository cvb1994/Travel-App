import 'package:flutter/material.dart';

class CustomNotify {
  final BuildContext context;

  const CustomNotify(this.context);

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
}
