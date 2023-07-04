import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputSearch extends StatefulWidget {
  final TextEditingController controller;

  const InputSearch({super.key, required this.controller});

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(96, 229, 225, 225),
        ),
        height: 50,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(
              width: 280,
              child: TextFormField(
                controller: widget.controller,
                style: const TextStyle(fontSize: 16),
                decoration:
                    InputDecoration.collapsed(hintText: "Search Destination"),
              ),
            ),
            SizedBox(
              width: 30,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            )
          ],
        ),
      ),
    );
  }
}
