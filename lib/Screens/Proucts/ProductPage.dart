import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'components/body.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:provider/provider.dart';
class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProductModel>>.value(
      value: Database().lData,
          child: Scaffold(
        appBar: AppBar(title: Text('Product List'),backgroundColor: Colors.blueGrey[900],),
        body: Body(),
      ),
    );
  }
}
