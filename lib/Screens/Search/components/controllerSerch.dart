import 'package:flutter_auth/Models/productmodel.dart';
import 'package:flutter_auth/Screens/Search/components/body.dart';
import 'package:flutter_auth/Services/database.dart';
import 'package:get/get.dart';

class SearchCpntroller extends GetxController {
  var products = Rx<List<ProductModel>>();
  final _debouncer = Debouncer(milliseconds: 1000);
  List<ProductModel> searchItems = List<ProductModel>().obs;
  var af = false.obs;
  var hildeAllProds = false.obs;
  
  List<ProductModel> get pord => products.value!=null?  products.value.reversed.toList():products.value;
  void showdata(String name) {
    af.value = true;
    if (name.trim().isNotEmpty) {
      print(af);
      pord.sort((a, b) =>
          a.prodName.toLowerCase().compareTo(b.prodName.toLowerCase()));
      _debouncer.run(() {
        searchItems.clear();
        
        if (name.isEmpty) {
          searchItems.clear();
         
        }
        pord.forEach((element) {
          // print(element.prodName)
          if (element.prodName.toLowerCase().startsWith(name.toLowerCase())) {
            af.value = false;
            hildeAllProds.value = false;
            searchItems.add(element);
          }
        });
      });
    } else {
      print('Empty');
      if (searchItems.isNotEmpty) {
        searchItems.clear();
      } else {
        searchItems.clear();
      }
      af.value = false;
    }
  }

  @override
  void onInit()async {
    products.bindStream(Database().lData);
    super.onInit();
  }
}
