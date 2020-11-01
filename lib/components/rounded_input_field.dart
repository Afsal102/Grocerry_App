import 'package:flutter/material.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController emailController;
  const RoundedInputField({
    Key key,
    @required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
   @required this.emailController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if(value.isEmpty){
            return "Email is  Empty";
          }
          if(value.length>0 && value.length<3){
            return "Please enter a proper email";
          }
          
          return null;
        },
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
