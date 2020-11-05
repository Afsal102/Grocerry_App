import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Services/ConnectivityStatues.dart';
import 'package:get/get.dart';

class NetworkProvider extends GetxController {

  var conectionstatus = ''.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        conectionstatus.value = result.toString() ;
        break;
      default:
        conectionstatus.value = 'Failed to get connectivity.';
        break;
    }
  }

  @override
  void onInit()async {
    super.onInit();
    initConnectivity();
     connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}
