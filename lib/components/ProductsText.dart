import 'package:flutter/material.dart';

class ProductsText extends StatelessWidget {
  final String text;
  final double fontSize;
  ProductsText({Key key, @required this.text, @required this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize),
        textAlign: TextAlign.start,
      ),
    );
  }
}
