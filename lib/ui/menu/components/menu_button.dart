import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuButton extends StatefulWidget {
  MenuButton(
      {Key? key,
      required this.title,
      required this.backgrounColor,
      this.borderColor,
      required this.fontWeight,
      required this.onPressed})
      : super(key: key);

  final String title;
  final Color backgrounColor;
  final Color? borderColor;
  final FontWeight fontWeight;
  final VoidCallback onPressed;

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 299.0,
      height: 52.0,
      decoration: BoxDecoration(
        color: this.widget.backgrounColor,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: this.widget.borderColor != null
                ? this.widget.borderColor!
                : HexColor('536DFE'),
            width: 1.0,
            style: BorderStyle.solid),
      ),
      child: TextButton(
        onPressed: this.widget.onPressed,
        child: Text(
          this.widget.title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ComicNeue',
            fontSize: 18.0,
            fontWeight: this.widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
