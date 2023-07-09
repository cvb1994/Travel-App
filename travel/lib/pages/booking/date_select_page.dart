import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateSelectPage extends StatefulWidget{
  String? dateRange;
  VoidCallback onCancel;
  VoidCallback onSave;
  DateRangePickerController controller;
  DateSelectPage({super.key, this.dateRange, required this.onCancel, required this.onSave, required this.controller});

  @override
  State<DateSelectPage> createState() => _DateSelectPageState();
}

class _DateSelectPageState extends State<DateSelectPage>{
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(149, 211, 209, 209),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: BorderDirectional(bottom: BorderSide(color: Color.fromARGB(255, 196, 193, 193), width: 0.6))
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(onPressed: widget.onCancel, icon: const Icon(Icons.cancel)),
                        const Text("Select Date")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 450,
                  child: SfDateRangePicker(
                    controller: widget.controller,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: BorderDirectional(top: BorderSide(color: Color.fromARGB(255, 196, 193, 193), width: 0.6))
                    ),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10), 
                          child: GestureDetector(
                            onTap: widget.onSave,
                            child: SizedBox(
                              width: 80,
                              height: 40,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber
                                ),
                                child: const Center(child: Text("Save"),),
                              ),
                            ),
                          ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        )
        
      ],
    );
  }
}
