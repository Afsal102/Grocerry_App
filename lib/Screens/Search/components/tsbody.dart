import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Search/components/body.dart';
import 'package:flutter_auth/Screens/Search/components/controllerSerch.dart';
import 'package:flutter_auth/components/ProductsCard.dart';
import 'package:flutter_auth/components/rounded_TextFormt_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TsBody extends StatelessWidget {
  final searchController = Get.put(SearchCpntroller());

  final txtcontroller = TextEditingController();
  final Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAlias,
        dragStartBehavior: DragStartBehavior.start,
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
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
                          searchController.showdata(value.trim().toLowerCase());
                        },
                        hintText: 'Search',
                        circular: 10,
                        icon: Icons.search,
                        inputAction: TextInputAction.go,
                        validator: (value) {},
                      ),
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(right: 10),
                  //     child: Icon(
                  //       Icons.sort,
                  //       size: 50,
                  //       color: Colors.purple[200],
                  //     )),
                ],
              ),
              GetX<SearchCpntroller>(
                builder: (controller) {
                  if (controller != null &&
                      controller.searchItems.isEmpty &&
                      txtcontroller.value.text.trim().isNotEmpty) {
                    controller.af.value = false;
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(
                          child: Text(
                            'No data Found!! Try Using a different KeyWord\t(Producs List Below)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }
                  return Offstage(
                    offstage: true,
                  );
                },
              ),
              GetX<SearchCpntroller>(
                builder: (controller) {
                  if (controller != null && controller.af.value == true) {
                    return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2 * 0.5,
                            bottom: 150),
                        child: SpinKitHourGlass(
                          color: Colors.purple[600],
                        ));
                  } else {
                    return Offstage(offstage: true);
                  }
                },
              ),
              Container(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GetX<SearchCpntroller>(
                    builder: (controller) {
                      if (controller != null &&
                          controller.pord != null &&
                          controller.af.value == false) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            clipBehavior: Clip.antiAlias,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return controller.searchItems.isNotEmpty
                                  ? Products(
                                      productModel:
                                          controller.searchItems[index],
                                    )
                                  : Products(
                                      productModel: controller.pord[index],
                                    );
                            },
                            itemCount: controller.searchItems.length == 0
                                ? controller.pord.length
                                : controller.searchItems.length,
                          ),
                        );
                      } else {
                        return Offstage(
                          offstage: true,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
