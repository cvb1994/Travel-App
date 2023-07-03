import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.fieldName,
    required this.textHint,
    required this.obscureText,
    required this.controller,
    required this.isRequired,
    this.validator,
  });
  final String fieldName;
  final String textHint;
  final bool obscureText;
  final bool isRequired;
  final TextEditingController controller;
  final String? Function(String?)? validator;

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
            padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
            child: TextFormField(
              validator: widget.validator,
              controller: widget.controller,
              obscureText: widget.obscureText,
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
