import 'package:flutter/material.dart';
import 'package:travel/widget/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  
  @override
  Widget build(BuildContext context) {
    double logoBox = MediaQuery.of(context).size.height * 0.3;
    double loginBox = MediaQuery.of(context).size.height * 0.4;
    double buttonBox = MediaQuery.of(context).size.height * 0.3;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
        child: Column(
          children: [
            SizedBox(
              height: logoBox,
              child: const Center(
                child: Text(
                  "Travel",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    fontSize: 30 )
                ),
              ),
            ),
            SizedBox(
              height: loginBox,
              child: Column(
                children: [
                  TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'E-Mail'),
                    ),
                  TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Pass'),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: buttonBox,
              child: Row(),
            ),
          ]),),
    );
  }

}