import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget{
  const FavoriteWidget({super.key, required this.isActive});
  final bool isActive;

   @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Icon(Icons.favorite_border, size: 25,),
        widget.isActive ? Icon(Icons.favorite, size: 25, color: Colors.red,) : Container()
      ],
    );
  }

  Widget _buildIconFavorite(double size, Color color) {
    return Container(
      height: 5,
      width: 5,
      alignment: Alignment.center,
      child: Icon(
        Icons.favorite,
        color: color,
        size: size,
      ),
    );
  }

}