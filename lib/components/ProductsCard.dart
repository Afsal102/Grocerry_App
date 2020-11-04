import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Screens/Edit/edit.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/components/ProductsText.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class Products extends StatefulWidget {
  final ProductModel productModel;
  Products({Key key, this.productModel}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        blurSize: 5.0,
        menuItemExtent: 40,
        menuBoxDecoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: Duration(milliseconds: 100),
        animateMenuItems: true,
        blurBackgroundColor: Colors.black54,
        menuOffset: 10.0,
        bottomOffsetHeight: 80.0,
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text("Edit"),
              trailingIcon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        productModel: widget.productModel,
                      ),
                    ));
              }),
          FocusedMenuItem(
              title: Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              trailingIcon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "RFLUTTER ALERT",
                  desc: "Flutter is more awesome with RFlutter Alert.",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "DELETE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        if (await Database()
                                .delete(widget.productModel.prodId) ==
                            true) {
                          Toast.show('Deleted', context,
                              duration: Toast.LENGTH_LONG);
                          Navigator.pop(context);
                        }
                      },
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              }),
        ],
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // width: (MediaQuery.of(context).size.width / 2),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: widget.productModel.imageLink,
                    placeholder: (context, url) => new SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4.0,
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          ),
                        )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProductsText(
                            text: widget.productModel.prodName.toUpperCase(),
                            fontSize: 13),
                        ProductsText(
                            text: 'RS :${widget.productModel.prodPrice}',
                            fontSize: 13),
                        ProductsText(
                            text: widget.productModel.availableQty,
                            fontSize: 13),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProductsText(
                            text: widget.productModel.prodId, fontSize: 13),
                        ProductsText(
                            text: widget.productModel.uploadDate, fontSize: 10),
                        ProductsText(
                            text: widget.productModel.weight == 'g'
                                ? 'GRAMS'
                                : 'KILO GRAMS',
                            fontSize: 14)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
