import 'package:flutter/material.dart';
import 'package:flutter_auth/Controllers/firstController.dart';
import 'package:flutter_auth/Screens/Search/components/controllerSerch.dart';

import 'package:flutter_auth/Services/NetworkProvider.dart';

import 'package:get/get.dart';

class Home extends StatelessWidget {
  final shoppingcontroller = Get.put(Shoppingcontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: Bodt(),
    );
  }
}

class Bodt extends StatefulWidget {
  @override
  _BodtState createState() => _BodtState();
}

class _BodtState extends State<Bodt> {
  final controllr = Get.put(Shoppingcontroller());
  final searchCOntroller = Get.put(SearchCpntroller());
  final netowrkController = Get.put(NetworkProvider());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [FlatButton(onPressed: () async {}, child: Text('Hello '))],
    ));
  }
}
