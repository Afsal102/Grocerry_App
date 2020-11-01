import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/loading.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final emcontroller = TextEditingController();
  final passcontrol = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading?Loading() : Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        _formkey.currentState.validate();
                      },
                      emailController: emcontroller,
                    ),
                    RoundedPasswordField(
                      passwordController: passcontrol,
                      onChanged: (value) {
                        _formkey.currentState.validate();
                      },
                    ),
                  ],
                )),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                if (_formkey.currentState.validate()) {
                  print('succes');
                  setState(() {
                    loading=true;
                  });
                  // print(emcontroller.text.toString());
                  // print(passcontrol.value.text.toString());
                  try {
                    User user = await database.signIn(
                        emcontroller.value.text.trim().toLowerCase(),
                        passcontrol.value.text.trim());

                    if (user != null) {
                      print('user id is ${user.uid}');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Wrapper(),
                      ));
                    } else {
                      setState(() {
                        loading=false;
                      });
                      print('invalid credentials');
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e.message.toString());
                    setState(() {
                      loading = false;
                    });
                    Toast.show(e.message.toString(), context,
                        duration: Toast.LENGTH_LONG);
                  } on PlatformException catch (e) {
                    print(e.message.toString());
                    setState(() {
                      loading = false;
                    });
                    Toast.show(e.message.toString(), context,
                        duration: Toast.LENGTH_LONG);
                  } catch (e) {
                    print(e.toString());
                    setState(() {
                      loading = false;
                    });
                    Toast.show(e.message.toString(), context,
                        duration: Toast.LENGTH_LONG);
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
