import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Transform/transform.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/constants.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      
      value: Database().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        title: 'Flutter Auth',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.solwayTextTheme(Theme.of(context).textTheme),
        ),
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<User>(context);

    if(user==null){
      
      return WelcomeScreen();
    }
    else{
      print(user.email);
      return Trasnform();
    }
  }
}
