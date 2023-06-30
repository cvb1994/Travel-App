import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {super.key, required this.fieldName, required this.textHint});
  final String fieldName;
  final String textHint;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  Color color = Colors.black;
  final FocusNode _focus = FocusNode();

  void _onFocusChange() {
    setState(() {
      color = color == Colors.black ? Colors.yellow : Colors.black;
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              focusNode: _focus,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                hintText: widget.textHint,
              ),
            )),
        Positioned(
            left: 40,
            top: 3,
            child: Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(250, 250, 250, 250)),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.fieldName,
                textAlign: TextAlign.justify,
                style: TextStyle(color: color != null ? color : Colors.black),
              ),
            ))
      ],
    );
  }
}
