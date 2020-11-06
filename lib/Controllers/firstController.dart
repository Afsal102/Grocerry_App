
import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:get/state_manager.dart';

class Shoppingcontroller extends GetxController {
  Rx<List<ProductModel>> products = Rx<List<ProductModel>>();

  List<ProductModel> get prods =>products.value;


  @override
  void onInit() {
    products.bindStream(Database().lData);
    super.onInit();
  }



  


}
