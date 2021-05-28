import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:samsow/models/like.dart';
import 'package:samsow/models/order.dart';
import 'package:samsow/models/user.dart';

@immutable
class Use{
  const Use({@required this.uid});
  final String uid;
}

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore database = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //create user with email and password
  Future createUser(String name, String email, String phone, String gender,
      String password) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;

      database.collection('users').doc(user.email).set({
        'email': user.email,
        'username': name,
        'phone': phone,
        'gender': gender
      });
      return result.user;
    } catch (e) {
      return null;
    }
  }

  //sign in user with password and email
  Future<Use> loginUser(String email, String password) async {
    try {
      final userResult =  await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _partnerFromFirebase(userResult.user);
    } catch (e) {
      return null;
    }
  }

  //get current user based on user email
  Future<Users> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot userData =
            await database.collection('users').doc(user.email).get();
        //print(userData.get('phone').toString());
        return Users(
          username: userData.get('username'),
          email: userData.get('email'),
          phone: userData.get('phone'),
        );
      }
    } catch (er) {
      return null;
    }
    return null;
  }

  //restart user's password
  Future sendNewPassword(String email) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return null;
    }
  }

  //logout user
  Future logoutUser() async {
    await _firebaseAuth.signOut().catchError((er) {
      return null;
    });
  }

  //check the user has already logged in or not
  Stream<Use> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((_partnerFromFirebase));
  }

  Future<bool> isLoggedIn()async{
     return await _firebaseAuth.authStateChanges().isEmpty;
  }

  //sign in with facebook
  Future loginUserWithFacebook() async {}

  Use _partnerFromFirebase(User user){
    return user == null ? null : Use(uid: user.uid);
  }

  //get images from firebase
  Future getUrlImage() async {
    await _storage.ref('images').getDownloadURL().catchError((er) {
      return null;
    });
  }

  //get your orders
  Future<List<Order>> getOrders() async {
    List<Order> prodOrder = [];
    await database
        .collection('orders')
        .where('customerEmail', isEqualTo: _firebaseAuth.currentUser.email)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final Order order = Order(
            orderId: element.get('orderId'),
            productId: element.get('productId'),
            quantity: element.get('quantity'),
            orderDate: element.get('orderDate'));
        prodOrder.add(order);
      });
    }).catchError((er) {
      return null;
    });
    return prodOrder;
  }

  //get your orders
  Future<List<Like>> getLikes() async {
    List<Like> prodLike = [];
    await database
        .collection('likes')
        .where('customerEmail', isEqualTo: _firebaseAuth.currentUser.email)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        final Like order = Like(
            likeId: element.get('likeId'), productId: element.get('productId'));
        prodLike.add(order);
      });
    }).catchError((er) {
      return null;
    });
    return prodLike;
  }

  //get the shops of our partner
  Future<List<String>> getShops() async {
    List<String> shops = [];
    await database.collection('partners').get().then((value) {
      value.docs.forEach((element) {
        shops.add(element.get('shop'));
      });
    }).catchError((er) {
      return null;
    });
    return shops;
  }
}
