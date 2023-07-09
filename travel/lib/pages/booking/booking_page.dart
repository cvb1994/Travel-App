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
import 'package:travel/pages/booking/date_select_page.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
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


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.withFunc(
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
            child: DateSelectPage(),
          ),
          CustomLinearProgess(
            currentStep: currentPage,
            totalStep: 3,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
