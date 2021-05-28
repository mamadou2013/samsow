import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samsow/screens/home.dart';
import 'package:samsow/screens/my_home.dart';
import 'package:samsow/services/user_service.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<UserService>(context,listen: false);
    return StreamBuilder(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final user = snapshot.data;
          return user != null ? MyHome() : HomePage();
        }else{
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
