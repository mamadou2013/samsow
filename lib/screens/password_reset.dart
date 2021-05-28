import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';
import 'package:samsow/services/user_service.dart';

class RestartPassword extends StatefulWidget {
  @override
  _RestartPasswordState createState() => _RestartPasswordState();
}

class _RestartPasswordState extends State<RestartPassword> {

  final formKey = GlobalKey<FormState>();

  final UserService userService = UserService();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            ExtendedNavigator.root.pop();
          },
        ),
        title: Text(
          'Password Reset',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Text(
                'Restart your Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(0), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: getColor(1), width: 2.0),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                      //border:
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if(value.isEmpty){
                        return 'The email is required';
                      }else if(Validator.email(emailController.text)){
                        // isEmailValid(emailController.text);
                        return 'Please enter a valid email';
                      }else{
                        return null;
                      }                    },
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          'Send an Email',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        onPressed: () async {
                          userService.sendNewPassword(emailController.text);

                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Color getColor(int num) {
    switch(num){
      case 1 : return Colors.green; break;
      case 2 : return Colors.red; break;
      default: return Colors.white;
    }
  }
}
