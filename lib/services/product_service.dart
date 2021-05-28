import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:samsow/models/product.dart';
import 'package:samsow/models/rate.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  var uuid = Uuid();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;
  int isSearched = 0;

  //get all products from fire store
  Stream<List<Product>> getAllProducts(){
    try{
      return database.collection('product').snapshots()
          .map((snapshot) => snapshot.docs
          .map((document)=> Product.fromFirestore(document.data()))
          .toList());
    }catch(er){
      return null;
    }
  }

  //ordering a product
  Future orderProduct(
      Product product, int orderQuantity, String size, String color) async {
    final qt = int.parse(product.productQtite) - orderQuantity;
    var id = uuid.v4();
    var date = DateTime.now();
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(date);
    try {
      await database.collection('orders').doc(id).set({
        'orderId': id,
        'productId': product.productId,
        'productName': product.productName,
        'customerEmail': _firebaseAuth.currentUser.email,
        'partnerEmail': product.ownerEmail,
        'quantity': orderQuantity.toString(),
        'orderDate': updatedDt,
        'size': size,
        'color': color,
        'confirmation': false
      });

      await _reduceQuantityProduct(product.productId, qt.toString());
    } catch (e) {
      print('network error');
    }
  }

  Future _reduceQuantityProduct(String productId, String qt) async {
    await database
        .collection('product')
        .doc(productId)
        .update({'quantity': qt}).catchError((er) {
      return null;
    });
  }

  //fetching the products being searched based on the user
  Future<List<String>> searchSuggestion() async {
    List<String> prod = [];
    await database
        .collection('searches')
        .where('userEmail', isEqualTo: _firebaseAuth.currentUser.email)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        prod.add(element.data()['productId']);
      });
    }).catchError((er) {
      return null;
    });
    return prod;
  }

  //store the history of user research into fire store
  Future createSearchHistory(String productId) async {
    // ignore: unrelated_type_equality_checks
    await _checkStatus(productId);
    if (isSearched == 1) {
      return null;
    } else {
      return await database.collection('searches').doc(uuid.v4()).set({
        'id': uuid.v4(),
        'productId': productId,
        'userEmail': _firebaseAuth.currentUser.email
      }).catchError((er) {
        return null;
      });
    }
  }

  //check whether the user has already searched this product or not
  Future _checkStatus(String productId) async {
    final result = await database
        .collection('searches')
        .where('productId', isEqualTo: productId)
        .get()
        .catchError((er) {
      return false;
    });
    isSearched = result.docs.length;
    return (result.docs.isEmpty);
  }

  //get the product based on the id receive
  Future<Product> getProduct(String productId) async {
    Product product;
    await database.collection('product').doc(productId).get().then((value) {
      product = Product(
          productId: value.get('productId'),
          productName: value.get('productName'),
          productOldPrice: value.get('productOldPrice'),
          productNewPrice: value.get('productNewPrice'),
          productDescription: value.get('description'),
          productPicture1: value.get('productPicture1'),
          productPicture2: value.get('productPicture2'),
          productPicture3: value.get('productPicture3'),
          productQtite: value.get('quantity'),
          ownerEmail: value.get('emailPartner'),
          category: value.get('category'),
          sizes: value.get('sizes'),
          colors: value.get('colors'));
    }).catchError((er) {
      return null;
    });

    //print('\n---prod----'+product.toString());
    return product;
  }

  //rated a product
  Future rateProduct(String productId, int numb, String description) async {
    String id = uuid.v4();
    return await database.collection('rates').doc(uuid.v4()).set({
      'rateId': id,
      'productId': productId,
      'customerEmail': _firebaseAuth.currentUser.email,
      'starNumber': numb,
      'description': description
    }).catchError((er) {
      return null;
    });
  }

  //liked a product
  Future likeProduct(String productId) async {
    String id = uuid.v4();
    try {
      return await database.collection('likes').doc(uuid.v4()).set({
        'likeId': id,
        'productId': productId,
        'customerEmail': _firebaseAuth.currentUser.email
      });
    } catch (e) {
      return null;
    }
  }

  //Check the product status
  Future checkProductStatus(String productId) async {
    bool status;
    await database.collection('product').doc(productId).get().then((value) {
      print(value.get('status'));
      status = value.get('status');
    }).catchError((er) {
      return null;
    });
    return status;
  }

  //fetch products from fire store based on category
  Future<List<Product>> getProductCategory(String category) async {
    List<Product> prod = [];
    await database
        .collection('product')
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Product product = Product(
            productId: element.get('productId'),
            productName: element.get('productName'),
            productOldPrice: element.get('productOldPrice'),
            productNewPrice: element.get('productNewPrice'),
            productDescription: element.get('description'),
            productPicture1: element.get('productPicture1'),
            productPicture2: element.get('productPicture2'),
            productPicture3: element.get('productPicture3'),
            productQtite: element.get('quantity'),
            ownerEmail: element.get('emailPartner'),
            category: element.get('category'),
            sizes: element.get('sizes'),
            colors: element.get('colors'));
        prod.add(product);
      });
    }).catchError((er) {
      return null;
    });
    //print(prod.);
    return prod;
  }

  //get the rate of the product
  Future<List<Rate>> getRate(String productId) async {
    List<Rate> rate = [];
    await database
        .collection('rates')
        .where('productId', isEqualTo: productId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Rate r = Rate(element.get('productId'), element.get('rateId'),
            element.get('starNumber'), element.get('description'));
        rate.add(r);
      });
    }).catchError((er) {
      return null;
    });
    return rate;
  }
}
