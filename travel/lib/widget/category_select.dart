import 'package:flutter/material.dart';

class CategorySelect extends StatefulWidget {
  final String imagePath;
  final String title;
  bool isSelected;

  CategorySelect(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.isSelected});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  void onChanged() {
    setState(() {
      widget.isSelected = !widget.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: (!widget.isSelected)
              ? Border.all(
                  width: 0.3,
                  style: BorderStyle.solid,
                  color: Color.fromARGB(117, 182, 180, 180),
                )
              : Border.all(
                  width: 0.8,
                  style: BorderStyle.solid,
                  color: Color.fromARGB(248, 3, 231, 87)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(widget.imagePath),
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
