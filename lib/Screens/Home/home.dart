import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Controllers/firstController.dart';
import 'package:flutter_auth/Screens/Search/components/controllerSerch.dart';
import 'package:flutter_auth/Services/ConnectivityStatues.dart';
import 'package:flutter_auth/Services/NetworkProvider.dart';

import 'package:get/get.dart';

import 'package:provider/provider.dart';

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
  String _conectionstatus = 'IDK';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

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
          child: Center(child: GetX<Shoppingcontroller>(
            builder: (cn) {
              if (cn != null && cn.prods != null) {
                return Text(
                    'Hellow ${cn.prods.length == 0 ? 0 : cn.prods.length},');
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
        ),
        GetX<SearchCpntroller>(
          builder: (cm) {
            if (cm != null && cm.showSpinkKit.value == false) {
              return FlatButton(
                  onPressed: () {
                    cm.showSpinkKit.value = true;

                    Future.delayed(Duration(seconds: 10), () async {
                      cm.showSpinkKit.value = false;
                    });
                  },
                  child: Text('Click to invoke Loading'));
            } else
              return Container();
          },
        ),
        FlatButton(
            onPressed: () async {
              var connectivity = await Connectivity().checkConnectivity();
              if (connectivity == ConnectivityResult.mobile) {
                print('Moblie');
                // I am connected to a mobile network.
              } else if (connectivity == ConnectivityResult.wifi) {
                // I am connected to a wifi network.
                print('Wifi');
              }
            },
            child: Text('Show Connction res')),
        Text('Idk For now $_conectionstatus'),
        GetX<NetworkProvider>(
       
     
          builder: (cm) {
            return Text('Gtfo ${cm.conectionstatus}');
          },
        )
      ],
    ));
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _conectionstatus = result.toString());
        break;
      default:
        setState(() => _conectionstatus = 'Failed to get connectivity.');
        break;
    }
  }
}
