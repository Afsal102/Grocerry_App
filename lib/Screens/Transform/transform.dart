import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Screens/AddRpoduct/addproduct.dart';
import 'package:flutter_auth/Screens/Profile/profile.dart';
import 'package:flutter_auth/Screens/Search/search.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';


import '../Home/home.dart';

class Trasnform extends StatefulWidget {
  @override
  _TransformState createState() => _TransformState();
}

class _TransformState extends State<Trasnform> {
  final List<Widget> _currentpage = [Home(), Search(), AddProduct(), Profile()];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return  StreamProvider<List<ProductModel>>.value(
      value: Database().lData,
          child: Scaffold(
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
      ),
    );
  }
}
