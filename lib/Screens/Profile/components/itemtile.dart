import 'package:flutter/material.dart';
import 'package:flutter_auth/Models/productmodel.dart';

class ProdTile extends StatelessWidget {
  final ProductModel productModel;
  ProdTile({Key key, this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.only(top: 8),
    //   child: Container(
    //     width: 300,
    //     height: 150,
    //     child: Card(
    //         margin: EdgeInsets.fromLTRB(20, 6, 20, 0),

    //         child: Stack(
    //           children: [
    //             Container(
    //               height: 200,
    //               width: 150,
    //               color: Colors.red,
    //             ),
    //           ],
    //         )),
    //   ),
    // );

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: (MediaQuery.of(context).size.width / 2) * 1.2,
            height: (MediaQuery.of(context).size.width / 2) ,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(productModel.imageLink),
                    fit: BoxFit.cover,
                    )),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height/2*0.5,
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2 * 0.33,
            ),
          ),
        )
      ],
    );
  }
}
//  ListTile(
//           title: Text(productModel.prodName),
//           leading: CircleAvatar(backgroundImage: NetworkImage(productModel.imageLink),),
//         ),
