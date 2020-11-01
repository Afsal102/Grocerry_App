import 'package:flutter/material.dart';

class ProfText extends StatelessWidget {
  final String text;
  final Color color;
  final GestureTapCallback gestureTapCallback;
  const ProfText({
    Key key,
    @required this.text,
    this.gestureTapCallback,
    this.color=Colors.white,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: gestureTapCallback,
        child: Text(text,style: TextStyle(fontSize: 14,color: color),)),
    );
  }
}
