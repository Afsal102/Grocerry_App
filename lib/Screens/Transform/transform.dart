import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Screens/AddRpoduct/addproduct.dart';
import 'package:flutter_auth/Screens/Profile/profile.dart';
import 'package:flutter_auth/Screens/Search/components/controllerSerch.dart';
import 'package:flutter_auth/Screens/Search/search.dart';
import 'package:flutter_auth/Services/NetworkProvider.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/components/loading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Home/home.dart';

class Trasnform extends StatefulWidget {
  @override
  _TransformState createState() => _TransformState();
}

//! Used The NetworkChacker Tomarrow Check for Internet access
class _TransformState extends State<Trasnform> {
  final List<Widget> _currentpage = [Home(), Search(), AddProduct(), Profile()];
  int currentindex = 0;
  final searchController = Get.put(SearchCpntroller());

  @override
  Widget build(BuildContext context) {
    return GetX<NetworkProvider>(
      init: NetworkProvider(),
      builder: (controller) {
        if (controller != null) {
          return controller.conectionstatus.value ==
                  ConnectivityResult.none.toString()
              ? Loading()
              : StreamProvider<List<ProductModel>>.value(
                  value: Database().lData,
                  child: GetX<SearchCpntroller>(
                    builder: (controller) {
                      if (controller != null &&
                          controller.showSpinkKit.value == true) {
                        return Loading();
                      } else {
                        return Scaffold(
                          bottomNavigationBar: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: BottomNavigationBar(
                              showSelectedLabels: false,
                              showUnselectedLabels: false,
                              type: BottomNavigationBarType.fixed,
                              elevation: 0.0,
                              iconSize: 21,
                              currentIndex: currentindex,
                              items: [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.home),
                                  label: 'Home',
                                  backgroundColor: Colors.blue,
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.search),
                                  label: 'Search',
                                  backgroundColor: Colors.blue,
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.add),
                                  label: 'Add',
                                  backgroundColor: Colors.blue,
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.person),
                                  label: 'Profile',
                                  backgroundColor: Colors.blue,
                                ),
                              ],
                              onTap: (value) {
                                setState(() {
                                  currentindex = value;
                                });
                              },
                            ),
                          ),
                          body: IndexedStack(
                            index: currentindex,
                            children: _currentpage,
                          ),
                        );
                      }
                    },
                  ));
        } else {
          return Offstage();
        }
      },
    );
  }
}
