import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class TextFormFieldContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final circular;
  const TextFormFieldContainer({
    Key key,
    this.child,
    this.circular,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: width==null?size.width:width,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(circular==null?29:circular),
      ),
      child: child,
    );
  }
}
