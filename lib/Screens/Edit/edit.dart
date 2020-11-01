import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'componets/body.dart';

// class EditPage extends StatefulWidget {
//   final  ProductModel productModel;
//   EditPage({Key key,@required this.productModel}):super(key: key);
//   @override
//   _EditPageState createState() => _EditPageState();
// }

// class _EditPageState extends State<EditPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit'),),
//       body: Body(productModel: productModel,),
//     );
    
//   }
// }
class EditPage extends StatelessWidget {
  final ProductModel productModel;
  EditPage({Key key,@required this.productModel}):super(key: key);
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: Text('Edit'),),
      body: Body(productModel: productModel,),
    );
  }
}