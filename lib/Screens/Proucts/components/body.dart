import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/components/ProductsCard.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  Body({Key key}):super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    List<ProductModel> data = Provider.of<List<ProductModel>>(context);
    return Container(
      child:   ListView.builder(
        physics: BouncingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Products(productModel: data[index]);
        },
        reverse: true,
        shrinkWrap: true,
      ),
    );
  }
}