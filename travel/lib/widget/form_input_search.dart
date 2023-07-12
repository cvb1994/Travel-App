import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputSearch extends StatefulWidget {
  final TextEditingController controller;
  final bool isEnable;

  const InputSearch({super.key, required this.controller, required this.isEnable});

  @override
  State<InputSearch> createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    double searchInputSize = MediaQuery.of(context).size.width * 0.7;

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
              width: searchInputSize,
              child: TextFormField(
                enabled: widget.isEnable,
                autofocus: true,
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
