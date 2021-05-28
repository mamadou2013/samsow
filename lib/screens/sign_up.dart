import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/services/user_service.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';


import 'package:samsow/shareds/form_field_validat.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  final UserService userService = UserService();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isVisible = true;
  String groupValue = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text(
          'Register',
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
                'Create an Account',
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
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(0), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: getColor(1), width: 2.0),
                      ),
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                    ),
                    onChanged: (value) {},
                    validator: (value) => FormFieldValidate.isFieldValid(usernameController.text, 'name')
            ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'male',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            leading: Radio(
                              value: 'male',
                              groupValue: groupValue,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'female',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            leading: Radio(
                              value: 'female',
                              groupValue: groupValue,
                              activeColor: Colors.pink,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                    ),
                    onChanged: (value) {},
                    validator: (value)=> FormFieldValidate.isEmailValid(emailController.text)
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(0), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: getColor(1), width: 2.0),
                      ),
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                    ),
                    onChanged: (value) {},
                    validator: (value) {
                      if(value.isEmpty){
                        return 'The phone number is required';
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: passwordController,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.no_encryption),
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(0), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: getColor(1), width: 2.0),
                      ),
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                    ),
                    onChanged: (value) {},
                    validator: (value) => FormFieldValidate.isPasswordValid(passwordController.text)
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: confirmPasswordController,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.no_encryption),
                      hintText: 'Confirm Password',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(0), width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: getColor(1), width: 2.0),
                      ),
                      focusedErrorBorder:  OutlineInputBorder(
                          borderSide:
                          BorderSide(color: getColor(2), width: 2.0)),
                    ),
                    onChanged: (value) {},
                    validator: (value) => FormFieldValidate.isPasswordValid(passwordController.text, confirmPasswordController.text)
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          'Sign Up ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            dynamic result = await userService.createUser(
                                usernameController.text,
                                emailController.text,
                                phoneController.text,
                                groupValue,
                                passwordController.text);
                            if (result != null) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Account create successfully! you can login now',
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white
                              );
                              ExtendedNavigator.root.push(Routes.signIn);
                            }
                          }
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 3.0, 7.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ExtendedNavigator.root.push(Routes.signIn);
                          },
                          child: Text(
                            'Login here ',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
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
