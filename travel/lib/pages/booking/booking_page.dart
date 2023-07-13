import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel/model/place_model.dart';
import 'package:travel/pages/booking/booking_success_page.dart';
import 'package:travel/pages/booking/people_select_page.dart';

import 'package:travel/widget/SubMenuWidget.dart';
import 'package:travel/widget/custom_appbar.dart';
import 'package:travel/enum/appBarFuncEnum.dart';
import 'package:travel/pages/booking/date_select_page.dart';
import 'package:intl/intl.dart';
import 'package:travel/util/stringExtension.dart';
import 'package:travel/widget/custom_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BookingPage extends StatefulWidget {
  static const routerName = "/bookingPage";
  final PlaceModel place;
  const BookingPage({super.key, required this.place});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? date;
  bool isSelectDate = false;
  bool isSelectPeople = false;
  final dateRangeController = DateRangePickerController();
  final adultController = TextEditingController();
  final childController = TextEditingController();
  int totalPeople = 0;
  double price = 0;
  double priceVat = 0;
  double priceTotal = 0;

  void saveSelectedDate(){
    setState(() {
      DateTime selectedDate = dateRangeController.selectedDate!;

      date = '${DateFormat('dd/MM/yyyy').format(selectedDate)}';
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
                Text(date ?? "Please Select Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
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
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("People", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text("${totalPeople == 0 ? "Select Quantity" : totalPeople.toString()} people", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300))
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
                child: const Text("EDIT", textAlign: TextAlign.end,),
              ),
              
            )
          ],
        ),
        const SizedBox(height: 20,),
        const SubRowMenu(name: "Price Detail", buttonName: "",),
        Row(
          children: [
            Expanded(
              child: Text("\$${widget.place.price} x $totalPeople people",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)
              )
            ),
            SizedBox(
              width: 80,
              child: Text("\$${price}", textAlign: TextAlign.end, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              
            )
          ],
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            const Expanded(
              child: Text("VAT 8%",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)
              )
            ),
            SizedBox(
              width: 80,
              child: Text("\$$priceVat", textAlign: TextAlign.end, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              
            )
          ],
        ),
        const SizedBox(height: 15,),
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(200, 201, 200, 199)),
          height: 1,
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            const Expanded(
              child: Text("Total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)
              )
            ),
            SizedBox(
              width: 80,
              child: Text("\$$priceTotal", textAlign: TextAlign.end, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
              
            )
          ],
        ),

        
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    void bookingSimulate() async{
      EasyLoading.show(status: 'loading...');
      await Future.delayed(const Duration(milliseconds: 1000));
      EasyLoading.dismiss();
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingSuccessScreen()),
        );
    }

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar.withFunc(
            funcType: AppBarFuncENum.OTHER,
          ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(padding: EdgeInsets.all(10), child: CustomButton(title: 'Booking', color: Colors.amber, func: bookingSimulate,))
          ),
          body: mainBookingPage(),
        ),
        isSelectDate ? DateSelectPage(
          controller: dateRangeController,
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
              price = (widget.place.price!*totalPeople).toPrecision(2);
              priceVat = (price*0.08).toPrecision(2);
              priceTotal = price + priceVat;
            });
          }, 
          childController: childController, 
          adultController: adultController,
        ) : Container()
      ],
    );

  }
}
