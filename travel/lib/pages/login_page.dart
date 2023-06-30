import 'package:flutter/material.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_checkbox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double logoBox = MediaQuery.of(context).size.height * 0.4;
    double loginBox = MediaQuery.of(context).size.height * 0.3;
    double buttonBox = MediaQuery.of(context).size.height * 0.3;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
        child: Column(children: [
          SizedBox(
            height: logoBox,
            child: const Center(
              child: Text("Travel",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35)),
            ),
          ),
          SizedBox(
            height: loginBox,
            child: Column(
              children:  [
                CustomFormField(
                    fieldName: 'Email', textHint: 'Enter Your Email', obscureText: false),
                SizedBox(height: 10,),
                CustomFormField(
                    fieldName: 'Passwword', textHint: 'Enter Your Password', obscureText: true),
                GridTileBar(
                  leading: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        CustomCheckBox(),
                        Text("Remember Me")
                      ],
                    ),
                  ),
                  title:const SizedBox(),
                  trailing:const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      child: Text("Forgot Password"),
                    ),
                  ),)
              ],
            ),
          ),
          SizedBox(
            height: buttonBox,
            child: Column(
              children: [
                CustomButton(page: LoginPage(), title: "Create Account", color: Colors.white),
                SizedBox(height: 15,),
                CustomButton(page: LoginPage(), title: "Sign In", color: Colors.amber),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
