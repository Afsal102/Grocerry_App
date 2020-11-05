import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_auth/Models/productmodel.dart';

class Database {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference reference =
      FirebaseFirestore.instance.collection("Products");

  Future<User> createUser(final email, final password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  Future<User> signIn(final email, final password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future signOut() async {
    return await auth.signOut();
  }

  Stream<User> get user {
    return auth.authStateChanges();
  }

  Future<bool> insertData(
      pname, pprice, availableQty, weightt, imageurl) async {
    // String key = database.reference().push.toString();
    bool data = false;
    DatabaseReference dbref = database.reference();
    //!Used realtime database to gennerate psuh id
    String pushKey = dbref.push().key;
    print('$pname $pprice $availableQty $weightt $imageurl');
    Reference reference =
        FirebaseStorage.instance.ref().child('Products/').child(pushKey);
    // await reference.putFile(imageurl).onComplete.then((value) async {
    //   String link = await value.ref.getDownloadURL();

    //   ProductModel productModel = new ProductModel(
    //       prodId: pushKey,
    //       prodName: pname,
    //       prodPrice: pprice,
    //       availableQty: availableQty,
    //       weight: weightt,
    //       uploadDate: DateTime.now().toString(),
    //       imageLink: link);

    //   await firebaseFirestore
    //       .collection('Products')
    //       .doc(pushKey)
    //       .set(productModel.toMap())
    //       .then((value) {
    //     print('success');
    //     data = true;
    //   }).catchError((onError) {
    //     print('errror');
    //   });
    // }).catchError((onError) {
    //   print('errror');
    // });
    await reference.putFile(imageurl).then((value) async {
      String link = await value.ref.getDownloadURL();

      ProductModel productModel = new ProductModel(
          prodId: pushKey,
          prodName: pname,
          prodPrice: pprice,
          availableQty: availableQty,
          weight: weightt,
          uploadDate: DateTime.now().toString(),
          imageLink: link);

      await firebaseFirestore
          .collection('Products')
          .doc(pushKey)
          .set(productModel.toMap())
          .then((value) {
        print('success');
        data = true;
      }).catchError((onError) {
        print('errror');
      });
    }).catchError((onEror) {
      print('Error');
    });

    // print(key);

    return data;
  }

  List<ProductModel> _listfromSnap(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return ProductModel(
        prodName: doc.data()['prodName'] ?? '',
        prodId: doc.data()['prodId'] ?? '',
        prodPrice: doc.data()['prodPrice'] ?? '',
        availableQty: doc.data()['availableQty'] ?? '',
        weight: doc.data()['weight'] ?? '',
        imageLink: doc.data()['imageLink'] ?? '',
        uploadDate: doc.data()['uploadDate'] ?? '',
      );
    }).toList();
  }

  Stream<List<ProductModel>> get lData {
    return reference.snapshots().map(_listfromSnap);
  }

  Future<bool> delete(ProductModel prodMod) async {
    bool data = false;
    await FirebaseStorage.instance
        .refFromURL(prodMod.imageLink)
        .delete()
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(prodMod.prodId)
          .delete()
          .then((value) {
        data = true;
      }).catchError((onError) {
        data = false;
      });
    }).catchError((onError) {
      print('Error');
      data = false;
    });

    return data;
  }

  // getSearchresult(final String name) {
  //   return FirebaseFirestore.instance
  //       .collection('Products')
  //       .where('prodName', isEqualTo: name)
  //       .where('availableQty',isEqualTo: "3300")
  //       .orderBy('uploadDate',descending: true)
  //       .get();
  Future<QuerySnapshot> searchQuery(String name) async {
    return await FirebaseFirestore.instance
        .collection('Products')
        .where('prodName', isEqualTo: name)
        .get();
  }
}
