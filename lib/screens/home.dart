import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/screens/carousel.dart';
import 'package:samsow/screens/category.dart';
import 'package:samsow/screens/product.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text('SamSow'),
        actions: [
          FlatButton(
            onPressed: (){
              ExtendedNavigator.root.push(Routes.signIn);
            },
            child: Text(
              'Login',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
              ),
            ),
            color: Colors.redAccent,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 5.0),
        color: Colors.grey[100],
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
              child: Container(height: 180.0, child: MyCarousel()),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
                child: FlatButton(
                  onPressed: (){
                    ExtendedNavigator.root.push(Routes.signUp);
                  },
                  child: Text(
                    'Sign up to be able to use our services',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                  ),
                  color: Colors.redAccent,
                )
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            ),
            Container(
              height: 80.0,
              child: ProductCategory(),
            ),
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Text(
                'Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 0.0),
              child: Container(height: 500.0,child: Products()),
            ),
          ],
        ),
      ),
    );
  }
}
