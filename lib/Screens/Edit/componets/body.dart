import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/components/rounded_TextFormt_field.dart';
import 'package:flutter_auth/components/text_Formfield_container.dart';

class Body extends StatefulWidget {
  final ProductModel productModel;
  Body({
    Key key,
    this.productModel,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File _imagee;
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  Future getimage() async {
    final image = await piker.getImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        setState(() {
          _imagee = File(image.path);
        });
      } else {
        Toast.show('Cancelled', context, duration: Toast.LENGTH_LONG);
      }
    });
  }

  final piker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    String dropdownValue = widget.productModel.weight;
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width,
                              maxHeight: 150.0),
                          child: GestureDetector(
                            onTap: () async {
                              print("tapped");
                              await getimage();
                            },
                            child: Card(
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.productModel.imageLink,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        RoundedInputFormField(
                          hintText: widget.productModel.prodName.toUpperCase(),
                          controller: nameController,
                          validator: (value) {},
                        ),
                        Row(
                          children: [
                            RoundedInputFormField(
                              validator: (value) {},
                              hintText: widget.productModel.prodPrice,
                              textInputType: TextInputType.number,
                              controller: priceController,
                              width:
                                  MediaQuery.of(context).size.width / 2 * 0.8,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundedInputFormField(
                                validator: (value) {},
                                hintText: widget.productModel.availableQty,
                                textInputType: TextInputType.number,
                                width: MediaQuery.of(context).size.width / 2,
                                controller: quantityController),
                          ],
                        ),
                        TextFormFieldContainer(
                          child: Center(
                            child: DropdownButton(
                              value: dropdownValue,
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value.toString();
                                  print(value.toString());
                                });
                              },
                              items: <String>[
                                "g",
                                "kg"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        FlatButton(
                            onPressed: () async {}, child: Text('Add Product')),
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
