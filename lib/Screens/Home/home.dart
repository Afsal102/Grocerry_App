import 'package:flutter/material.dart';
import 'package:flutter_auth/Controllers/firstController.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetX<Shoppingcontroller>(
          builder: (controller) {
            if (controller != null && controller.prods != null) {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.prods.length == 0
                      ? 0
                      : controller.prods.length,
                  itemBuilder: (context, index) {
                    return Text(controller.prods[index].prodName);
                  },
                ),
              );
            } else {
              return Text('Loading');
            }
          },
        ),
        Expanded(
          child: Center(
            child: GetX<Shoppingcontroller>(
            builder: (cn) {
              if(cn!=null && cn.prods !=null){
              return Text(
                  'Hellow ${cn.prods.length == 0 ? 0 : cn.prods.length},');
              }
              else{
                return CircularProgressIndicator();
              }
            },
          )),
        ),
      ],
    ));
  }
}
