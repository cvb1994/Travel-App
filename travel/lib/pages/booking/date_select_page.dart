import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class DateSelectPage extends StatefulWidget{
  DateSelectPage();

  @override
  State<DateSelectPage> createState() => _DateSelectPageState();
}

class _DateSelectPageState extends State<DateSelectPage>{
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  Widget build(BuildContext context) {
    return DatePickerDialog(
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now(),
    );
  }

}
