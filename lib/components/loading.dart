import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.purple[100],
      child: Center(
        child: SpinKitWave(
          color: Colors.purple,
          size: 50.0,
        ),
      ),
    );
  }
}
