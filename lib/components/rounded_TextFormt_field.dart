import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_Formfield_container.dart';

import 'package:flutter_auth/constants.dart';

class RoundedInputFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double circular;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType textInputType;
  final double width;
  final FormFieldValidator<String> validator;
  final TextInputAction inputAction;
  const RoundedInputFormField({
    Key key,
    @required this.hintText,
    this.icon ,
    this.onChanged,
    this.circular,
    this.textInputType,
    this.inputAction,
    this.width,
   @required this.validator,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldContainer(
      circular: circular,
      width: width,
      child: icon!=null? TextFormField(
        textInputAction: inputAction,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType: textInputType,
        decoration: InputDecoration(
          icon:Icon(icon,color: kPrimaryColor,),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ):
      TextFormField(
        textInputAction: inputAction,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
      
    );
  }
}
