import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Proucts/ProductPage.dart';
import 'package:flutter_auth/components/prof_text.dart';


class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(top: 10, left: 9, right: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blueGrey[900],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfText(text: "Products"),
                    ProfText(
                      text: "View all",
                      color: Colors.orange[300],
                      gestureTapCallback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductList(),
                            ));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ProfText(text: "View all Orders"),
                SizedBox(
                  height: 10,
                ),
                ProfText(text: "View all Orders"),
              ],
            ),
          ),
          
        ],
      )),
    );
  }
}
