import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Screens/NoResultPage/noresuiltpage.dart';


import 'package:flutter_auth/components/rounded_TextFormt_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ProductModel> tempData = List<ProductModel>();
  bool show = true;
  bool wttodo = false;
  bool noResult = false;
  bool h = false;
  final txtcontroller = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  _sortByWeight(String prodName, List<ProductModel> data) {
    List<ProductModel> tdata = List<ProductModel>();
    data.forEach((element) {
      int price = int.parse(element.prodPrice);
      if (element.prodName.contains(prodName.toLowerCase())) {
        if (price > 200) {
          tdata.add(element);
        }
      }
    });

    tdata.forEach((element) {
      print(element.prodName);
    });
  }

  _sortAllProducts(List<ProductModel> list) {
    list.sort(
        (a, b) => int.parse(a.prodPrice).compareTo(int.parse(b.prodPrice)));
    list.forEach((element) {
      print(element.prodPrice + ' ' + element.prodName);
    });
  }

  _listofnamesStart(List<ProductModel> list) {
    list.sort((a, b) => a.prodName.compareTo(b.prodName));
    list.forEach((element) {
      print(element.prodName);
    });
  }

  _sortByletter(List<ProductModel> list) {
    List<ProductModel> prods = List<ProductModel>();
    const letter = 'com';
    list.forEach((element) {
      if (element.prodName.startsWith(letter)) {
        prods.add(element);
      }
    });
    if (prods.isEmpty) {
      print('No data found fo those results');
    }
    prods.forEach((element) {
      print(element.prodName);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> data = Provider.of<List<ProductModel>>(context);
    return SafeArea(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: RoundedInputFormField(
                        controller: txtcontroller,
                        onChanged: (value) {
                          setState(() {
                            wttodo = true;
                            show = false;
                          });
                          if (value.isNotEmpty) {
                            _debouncer.run(() {
                              tempData.clear();
                              data.forEach((element) {
                                if (element.prodName.startsWith(value.trim())) {
                                  setState(() {
                                    wttodo = false;
                                    noResult = false;
                                    h = true;
                                    tempData.add(element);
                                  });
                                }
                              });
                              if (tempData.isEmpty) {
                                setState(() {
                                  tempData.clear();
                                  noResult = true;
                                  wttodo = false;
                                  h = false;
                                });
                              }
                            });
                          } else {
                            setState(() {
                              tempData.clear();
                              wttodo = false;
                              h = false;
                              noResult = false;
                              show = true;
                            });
                          }
                        },
                        hintText: 'Search',
                        circular: 10,
                        icon: Icons.search,
                        inputAction: TextInputAction.go,
                        validator: (value) {},
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.sort,
                        size: 50,
                        color: Colors.purple[200],
                      )),
                ],
              ),
              h == true
                  ? Expanded(
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tempData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(tempData[index].prodName));
                          },
                        ),
                      ),
                    )
                  : Text(''),
              show == true
                  ? Expanded(
                      child: Container(
                          margin: EdgeInsets.only(
                              top:
                                  MediaQuery.of(context).size.height / 2 * 0.5),
                          child: Center(child: NoResultPage())),
                    )
                  : Offstage(offstage: true, child: Text('')),
              noResult == true
                  ? Text('No Results found',)
                  : Offstage(offstage: true, child: Text('')),
              wttodo
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2 * 0.5,
                          bottom: 150),
                      child: SpinKitHourGlass(
                        color: Colors.purple[600],
                      ))
                  : Offstage(
                      offstage: true,
                      child: Text(
                        '',
                      )),
            ],
          ),
        );
      }),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

