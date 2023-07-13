import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/auth_provider.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_checkbox.dart';
import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:travel/util/custom_notify.dart';
import 'package:travel/pages/auth/create_account.dart';
import 'package:travel/pages/dashboard.dart';
import 'package:travel/util/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomNotify notify = CustomNotify(context);

    double logoBox = MediaQuery.of(context).size.height * 0.4;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    void login() {
      if (_formKey.currentState!.validate()) {
        EasyLoading.show(status: 'loading...');
        Future? resp = context
            .read<AuthProvider>()
            .login(emailController.text, passwordController.text);

        resp.then((value) {
          ResponseModel respDto = value;
          if (respDto.responseCode == ResponseCodeEnum.SUCCESS) {
            EasyLoading.dismiss();
            Navigator.of(context).pushNamed(Dashboard.routerName);
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
          } else {
            EasyLoading.dismiss();
            notify.showNotify(respDto.message!);
          }
        }).catchError((e) {
          EasyLoading.dismiss();
          notify.showNotify(e);
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
        child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: logoBox,
                child:  Center(
                  child: Image.asset("assets/image/logo.png", scale: 0.7,)
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
                      validator: (val) {
                        if (val == null || val.isEmpty || val.trim() == "") {
                          return "Please input your email";
                        } else if (!val.isValidEmail) {
                          return "Your email format not correct";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                      controller: passwordController,
                      fieldName: 'Passwword',
                      textHint: 'Enter Your Password',
                      obscureText: true,
                      isRequired: true,
                      validator: (val) {
                        if (val == null || val.isEmpty || val.trim() == "") {
                          return "Please input password";
                        }
                        return null;
                      },
                    ),
                    const GridTileBar(
                      leading: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: [CustomCheckBox(), Text("Remember Me")],
                        ),
                      ),
                      title:  SizedBox(),
                      trailing: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          child: Text("Forgot Password"),
                        ),
                      ),
                    ),
                    CustomButton(
                        func: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateAccountPage()),
                              )
                            },
                        title: "Create Account",
                        color: Colors.white),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                        func: login, title: "Sign In", color: Colors.amber
                        // func: (){
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()));
                        // }, title: "Sign In", color: Colors.amber
                      ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
