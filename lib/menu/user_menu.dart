import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:samsow/models/like.dart';
import 'package:samsow/models/order.dart';
import 'package:samsow/models/user.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/screens/user_like.dart';
import 'package:samsow/screens/user_order.dart';
import 'package:samsow/services/user_service.dart';
import 'package:samsow/services/product_service.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final UserService userservice = UserService();
  final ProductService productService = ProductService();
  

  @override
  Widget build(BuildContext context) {
    final Users user = Provider.of<Users>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text('${user.username}'),
              accountEmail: Text('${user.email}'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Text('${user.username.characters.first.toUpperCase()}',style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),)
                  /*Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),*/
                ),
              ),
            decoration: BoxDecoration(color: Colors.redAccent),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shopping_basket,
              color: Colors.redAccent,
            ),
            title: Text('Orders'),
            onTap: () async {
              final List<Order> order = await userservice.getOrders();
              if (order.isNotEmpty) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyOrder(order)));
              } else {
                Fluttertoast.showToast(
                    msg: 'You have not done any order yet!',
                    backgroundColor: Colors.green,
                    textColor: Colors.white);
               ExtendedNavigator.root.push(Routes.userHome);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite_outlined, color: Colors.redAccent),
            title: Text('Favorite Products'),
            onTap: () async {
              final List<Like> likes = await userservice.getLikes();
              if (likes.isNotEmpty) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLike(likes)));
              } else {
                Fluttertoast.showToast(
                    msg:
                        'Try to like at least one product before using this link',
                    backgroundColor: Colors.green,
                    textColor: Colors.white);
                ExtendedNavigator.root.push(Routes.userHome);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit, color: Colors.redAccent),
            title: Text('home'),
            onTap: () {
              ExtendedNavigator.root.replace(Routes.myHome);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.redAccent),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.wifi_lock, color: Colors.redAccent),
            title: Text('Log Out'),
            onTap: () async {
              //final authService = Provider.of<UserService>(context,listen: false);
              //await authService.logoutUser();
              ExtendedNavigator.root.replace(Routes.homePage);
            },
          ),
        ],
      ),
    );
  }
}
