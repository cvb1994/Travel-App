import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/booking/people_select_page.dart';
import 'package:travel/pages/create_welcome.dart';
import 'package:travel/provider/auth_provider.dart';

import 'package:travel/enum/reponse_enum.dart';
import 'package:travel/model/response_model.dart';
import 'package:travel/util/validator.dart';
import 'package:travel/widget/SubMenuWidget.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:travel/widget/custom_form_field.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/widget/custom_linearProgres.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:travel/util/custom_notify.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/pages/booking/date_select_page.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  final PlaceModel place;
  const BookingPage({super.key, required this.place});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? dateRange;
  bool isSelectDate = false;
  bool isSelectPeople = false;
  final dateRangeController = DateRangePickerController();
  final adultController = TextEditingController();
  final childController = TextEditingController();
  int totalPeople = 0;

  void saveSelectedDate(){
    setState(() {
      dateRange = '${DateFormat('dd/MM/yyyy').format(dateRangeController.selectedRange!.startDate!)} -'
            ' ${DateFormat('dd/MM/yyyy').format(dateRangeController.selectedRange!.endDate!)}';
      isSelectDate = false;
    });
    
  }

  Widget mainBookingPage(){
    return Padding(padding: EdgeInsets.all(10),
    child: Column(
      children: [
        SizedBox(
          height: 80,
          child: Row(children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: NetworkImage(widget.place.image!), fit: BoxFit.cover)
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.place.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5,),
                Text(widget.place.des!, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 155, 153, 153)),),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14,),
                    Text(widget.place.rate!.toString())
                  ],
                )
                
              ],
            ))
          ]),
        ),
        const SubRowMenu(name: "Your Trip", buttonName: "",),
        Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text(dateRange ?? "Please Select Date")
              ],
            )),
            SizedBox(
              width: 80,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectDate = true;
                  });
                },
                child: Text("EDIT", textAlign: TextAlign.end,),
              ),
              
            )
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("People", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text("${totalPeople == 0 ? "Please Select People Quantity" : totalPeople.toString()} people")
              ],
            )),
            SizedBox(
              width: 80,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectPeople = true;
                  });
                },
                child: Text("EDIT", textAlign: TextAlign.end,),
              ),
              
            )
          ],
        ),
        const SizedBox(height: 15,),
        const SubRowMenu(name: "Price Detail", buttonName: "",),
        
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar.withFunc(
            funcType: AppBarFuncENum.OTHER,
          ),
          body: mainBookingPage(),
        ),
        isSelectDate ? DateSelectPage(
          controller: dateRangeController,
          dateRange : dateRange,
          onCancel: () {
            setState(() {
              isSelectDate = false;
            });
          },
          onSave: saveSelectedDate,
        ) : Container(),
        isSelectPeople ? PeopleSelectPage(
          onCancel: () {
            setState(() {
              isSelectPeople = false;
            });
          },
          onSave: (){
            setState(() {
              isSelectPeople = false;
              int adults = 0;
              int child = 0;
              try {
                adults = int.parse(adultController.text);
              } on Exception {}
              try {
                child = int.parse(childController.text);
              } on Exception {}
              
              totalPeople = adults + child;
            });
          }, 
          childController: childController, 
          adultController: adultController,
        ) : Container()
      ],
    );

  }
}
