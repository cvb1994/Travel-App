import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel/pages/create_welcome.dart';
import 'package:travel/provider/auth_provider.dart';

import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:travel/util/validator.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/custom_linearProgres.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:travel/util/custom_notify.dart';
import 'package:travel/enum/appBarFuncEnum.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> passFormKey = GlobalKey<FormState>();
  String currentPageName = "name";
  bool toggleCheck = false;
  int currentPage = 1;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final rePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomNotify notify = CustomNotify(context);
    double logoBox = MediaQuery.of(context).size.height * 0.3;
    double contentBox = MediaQuery.of(context).size.height * 0.45;
    double paddingSizeWidth = MediaQuery.of(context).size.width * 0.1;

    Widget namePage() {
      return Form(
          key: nameFormKey,
          child: Padding(
            key: const Key("namePageKey"),
            padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
            child: Column(children: [
              SizedBox(
                height: logoBox,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Create Your Account",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "What is your name?",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: contentBox,
                child: Column(
                  children: [
                    CustomFormField(
                        controller: firstNameController,
                        fieldName: 'First name',
                        textHint: 'Enter your first name',
                        obscureText: false,
                        isRequired: true,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim() == "") {
                            return "Please input first name";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                        controller: lastNameController,
                        fieldName: 'Last name',
                        textHint: 'Enter your last name',
                        obscureText: false,
                        isRequired: true,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim() == "") {
                            return "Please input last name";
                          }
                          return null;
                        }),
                  ],
                ),
              )
            ]),
          ));
    }

    Widget emailPage() {
      return Form(
          key: emailFormKey,
          child: Padding(
            key: const Key("emailPageKey"),
            padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
            child: Column(children: [
              SizedBox(
                height: logoBox,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Create Your Account",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "And, your email?",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: contentBox,
                child: Column(
                  children: [
                    CustomFormField(
                        controller: emailController,
                        fieldName: 'Email',
                        textHint: 'Enter your email',
                        obscureText: false,
                        isRequired: true,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim() == "") {
                            return "Please input email";
                          } else if (!val.isValidEmail) {
                            return "Your email format not correct";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Text(
                          "I'd like to received marketing and policy communication from traver and it's partners.",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 161, 159, 159),
                              height: 1.5),
                        )),
                        FlutterSwitch(
                          value: toggleCheck,
                          onToggle: (val) {
                            setState(() {
                              toggleCheck = val;
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ));
    }

    Widget passPage() {
      return Form(
          key: passFormKey,
          child: Padding(
            key: const Key("passPageKey"),
            padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
            child: Column(children: [
              SizedBox(
                height: logoBox,
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Create Your Account",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Create a password",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: contentBox,
                child: Column(
                  children: [
                    CustomFormField(
                        controller: passController,
                        fieldName: 'Password',
                        textHint: 'Enter your password',
                        obscureText: true,
                        isRequired: true,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim() == "") {
                            return "Please input password";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                        controller: rePassController,
                        fieldName: 'Re-type',
                        textHint: 'Re-type your password',
                        obscureText: true,
                        isRequired: true,
                        validator: (val) {
                          if (val == null || val.isEmpty || val.trim() == "") {
                            return "Please re-type password";
                          } else if (passController.text != val) {
                            return "Your password not match";
                          }
                          return null;
                        }),
                  ],
                ),
              )
            ]),
          ));
    }

    Widget renderWidget() {
      if (currentPageName == 'email') {
        return emailPage();
      } else if (currentPageName == 'pass') {
        return passPage();
      } else {
        return namePage();
      }
    }

    void signup() {
      String password = passController.text;
      String rePassword = rePassController.text;
      if (passFormKey.currentState!.validate()) {
        if (password == rePassword) {
          EasyLoading.show(status: 'loading...');
          Future? resp = context.read<AuthProvider>().signup(
              emailController.text,
              passController.text,
              firstNameController.text,
              lastNameController.text);

          resp.then((value) {
            ResponseModel respDto = value;
            if (respDto.responseCode == ResponseCodeEnum.SUCCESS) {
              EasyLoading.dismiss();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreatedWelcomeScreen()));
            } else {
              EasyLoading.dismiss();
              notify.showNotify(respDto.message!);
            }
          }).catchError((e) {
            EasyLoading.dismiss();
            notify.showNotify(e);
          });
        } else {}
      }
    }

    void onNext() {
      if (currentPageName == 'name') {
        if (nameFormKey.currentState!.validate()) {
          setState(() {
            currentPageName = 'email';
            currentPage = 2;
          });
        }
      } else if (currentPageName == 'email') {
        if (emailFormKey.currentState!.validate()) {
          setState(() {
            currentPageName = 'pass';
            currentPage = 3;
          });
        }
      }
    }

    void onPrevious() {
      if (currentPageName == 'name') {
        Navigator.of(context).pop();
      } else if (currentPageName == 'email') {
        setState(() {
          currentPage = 1;
          currentPageName = 'name';
        });
      } else if (currentPageName == 'pass') {
        setState(() {
          currentPage = 2;
          currentPageName = 'email';
        });
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.withFunc(
        onTap: onPrevious,
        funcType: AppBarFuncENum.OTHER,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 0),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: animation.drive(
                    Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.ease))),
                child: child,
              );
            },
            child: renderWidget(),
          ),
          CustomLinearProgess(
            currentStep: currentPage,
            totalStep: 3,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingSizeWidth),
              child: currentPage == 3
                  ? CustomButton(
                      title: "Create Account",
                      func: signup,
                      color: Colors.amber,
                    )
                  : CustomButton(
                      title: "Next",
                      func: onNext,
                      color: Colors.amber,
                    ))
        ],
      ),
    );
  }
}
