import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:flutter_auth/components/loading.dart';
import 'package:flutter_auth/components/rounded_TextFormt_field.dart';
import 'package:flutter_auth/components/text_Formfield_container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File _imagee;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'g';
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final piker = ImagePicker();
  bool loading = false;
  //!using image picker
  Future getimage() async {
    final image = await piker.getImage(source: ImageSource.camera,imageQuality: );

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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        
        : SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(10.0),
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
                                      maxWidth:
                                          MediaQuery.of(context).size.width,
                                      maxHeight: 150.0),
                                  child: GestureDetector(
                                    onTap: () async {
                                      print("tapped");
                                      await getimage();
                                    },
                                    child: Card(
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: _imagee == null
                                              ? Image.network(
                                                  "https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                )
                                              : Image.file(
                                                  _imagee,
                                                  alignment: Alignment.center,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                RoundedInputFormField(
                                  onChanged: (value) =>
                                      _formKey.currentState.validate(),
                                  hintText: "Product Name",
                                  controller: nameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Product Name is Empty";
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    RoundedInputFormField(
                                      onChanged: (value) =>
                                          _formKey.currentState.validate(),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return " Product Price is Empty";
                                        }

                                        return null;
                                      },
                                      hintText: "Product Price",
                                      textInputType: TextInputType.number,
                                      controller: priceController,
                                      width: MediaQuery.of(context).size.width /
                                          2 *
                                          0.8,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    RoundedInputFormField(
                                        onChanged: (value) =>
                                            _formKey.currentState.validate(),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Product Quantity is Empty";
                                          }
                                          return null;
                                        },
                                        hintText:
                                            "Available Quantity eg: 10g/kg",
                                        textInputType: TextInputType.number,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
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
                                      items: <String>["g", "kg"]
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                FlatButton(
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        print("succes");
                                        setState(() {
                                          loading = true;
                                        });
                                        // bool result = await Database().insertData(
                                        //     nameController.value.text.toString(),
                                        //     priceController.value.text.toString(),
                                        //     quantityController.value.text
                                        //         .toString(),
                                        //     dropdownValue,
                                        //     _imagee);
                                        //     print(nameController.value.text.toString());
                                        if (await Database().insertData(
                                                nameController.value.text
                                                    .toString(),
                                                priceController.value.text
                                                    .toString(),
                                                quantityController.value.text
                                                    .toString(),
                                                dropdownValue,
                                                _imagee) ==
                                            true) {
                                          setState(() {
                                            loading = false;
                                            _imagee = null;
                                          });
                                          Toast.show(
                                              'Product added successfully',
                                              context,
                                              duration: Toast.LENGTH_LONG);
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });

                                          Toast.show('Error Occured', context,
                                              duration: Toast.LENGTH_LONG);
                                        }
                                      }
                                    },
                                    child: Text('Add Product')),
                              ],
                            )),
                      ),
                    ],
                  )),
            ),
          );
  }
}
//!continuation form tommarwo
