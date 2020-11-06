import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NetworkProvider extends GetxController {
  var conectionstatus = ''.obs;
  var isDeviceConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    //used to get the connectivity type when the controlleris initialized
    try {
      
      result = await _connectivity.checkConnectivity();
      if(result!=ConnectivityResult.none){
        isDeviceConnected.value = await DataConnectionChecker().hasConnection;
      }
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
        conectionstatus.value = result.toString();
        break;
      default:
        conectionstatus.value = 'Failed to get connectivity.';
        break;
    }
    // if(result!=ConnectivityResult.none){
    //   isDeviceConnected.value=await DataConnectionChecker().hasConnection;
    // }
  }

  @override
  void onInit() async {
    super.onInit();
        var logger = Logger();
    logger.i('Initialized');

    initConnectivity();
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    var logger = Logger();
    logger.i('Disposed');
    super.dispose();
  }
}
