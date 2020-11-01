import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/loading.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

import '../../../main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final emcontroller = TextEditingController();
  final passcontrol = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading?Loading():Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    RoundedInputField(
                      emailController: emcontroller,
                      hintText: "Your Email",
                      onChanged: (value) {
                        formkey.currentState.validate();
                      },
                    ),
                    RoundedPasswordField(
                      passwordController: passcontrol,
                      onChanged: (value) {
                        formkey.currentState.validate();
                      },
                    ),
                  ],
                )),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                try {
                  if (formkey.currentState.validate()) {
                    print('success');
                    setState(() {
                      loading = true;
                    });
                    User user = await database.createUser(
                        emcontroller.value.text.trim().toLowerCase(),
                        passcontrol.value.text.trim());
                    if (user != null) {
                      print(user.uid);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Wrapper(),
                      ));
                    } else {
                      print("no user registered");
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Toast.show(e.message.toString(), context,
                      duration: Toast.LENGTH_LONG);
                } on PlatformException catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Toast.show(e.message.toString(), context,
                      duration: Toast.LENGTH_LONG);
                } catch (e) {
                  setState(() {
                    loading = false;
                  });
                  Toast.show(e.toString(), context,
                      duration: Toast.LENGTH_LONG); 
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
