import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsow/menu/user_menu.dart';
import 'package:samsow/models/user.dart';
import 'package:samsow/services/user_service.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  final userService=UserService();

  @override
  Widget build(BuildContext context) {
    final Users user=Provider.of<Users>(context);
    //userService.getCurrentUser();
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text('Welcome to your Account'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.white),
          )
        ],
      ),
      body: (user != null) ? Text('${user.username}'):Center(child: CircularProgressIndicator())
    );
  }
}
