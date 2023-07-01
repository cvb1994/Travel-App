import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_checkbox.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:travel/util/custom_notify.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CustomNotify notify = CustomNotify(context);
    double logoBox = MediaQuery.of(context).size.height * 0.4;
    double loginBox = MediaQuery.of(context).size.height * 0.3;
    double buttonBox = MediaQuery.of(context).size.height * 0.3;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void login() {
      if (_formKey.currentState!.validate()) {
        Future? resp = context
            .read<AuthProvider>()
            .login(emailController.text, passwordController.text);

        resp.then((value) {
          ResponseModel respDto = value;
          if (respDto.responseCode == ResponseCodeEnum.SUCCESS) {
          } else {
            notify.showNotify(respDto.message!);
          }
        }).catchError((e) {
          notify.showNotify(e);
        });
      }
    }

    void signup() {
      Future? resp = context
          .read<AuthProvider>()
          .signup(emailController.text, passwordController.text);

      resp.then((value) {
        ResponseModel respDto = value;
        if (respDto.responseCode == ResponseCodeEnum.SUCCESS) {
        } else {
          notify.showNotify(respDto.message!);
        }
      }).catchError((e) {
        notify.showNotify(e);
      });
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
        child: Form(
            key: _formKey,
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
              Expanded(
                child: Column(
                  children: [
                    CustomFormField(
                      controller: emailController,
                      fieldName: 'Email',
                      textHint: 'Enter Your Email',
                      obscureText: false,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFormField(
                        controller: passwordController,
                        fieldName: 'Passwword',
                        textHint: 'Enter Your Password',
                        obscureText: true,
                        isRequired: true),
                    GridTileBar(
                      leading: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: [CustomCheckBox(), Text("Remember Me")],
                        ),
                      ),
                      title: const SizedBox(),
                      trailing: const Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          child: Text("Forgot Password"),
                        ),
                      ),
                    ),
                    CustomButton(
                        func: signup,
                        title: "Create Account",
                        color: Colors.white),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                        func: login, title: "Sign In", color: Colors.amber),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
