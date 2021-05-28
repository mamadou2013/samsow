import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:samsow/route/router.gr.dart';
import 'package:samsow/services/user_service.dart';
import 'package:samsow/shareds/form_field_validat.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  final UserService userService = UserService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   Color colorsEmailBorder = Colors.white;
   Color colorsEmailBorderTap = Colors.white;
    int num = 0;
  Color colorsPasswordBorder = Colors.red;


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text(
          'Login',
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
                'Login to your Account',
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
                    validator: (value) => FormFieldValidate.isEmailValid(emailController.text)
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: passwordController,
                    obscureText: true,
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
                  Container(
                    padding: EdgeInsets.fromLTRB(140.0, 2.0, 5.0, 0.0),
                    //alignment: Alignment.,
                    child: InkWell(
                      onTap: () {
                        ExtendedNavigator.root.push(Routes.restartPassword);
                      },
                      child: Text(
                        'Forgot password ?',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            dynamic result = await authService.loginUser(
                                emailController.text, passwordController.text);
                            if (result != null) {
                              ExtendedNavigator.of(context).replace(Routes.myHome);
                            }else{
                              Fluttertoast.showToast(
                                  msg: 'Email or password not correct',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white
                              );
                            }
                          }
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Do not have an account?',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ExtendedNavigator.root.push(Routes.signUp);
                          },
                          child: Text(
                            'Register here ',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5.0),
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Text(
                          'Sign Up with facebook',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        onPressed: () {
                          Fluttertoast.showToast(msg:
                              'This functionality is not available actually so try sign up with your email',
                              backgroundColor: Colors.green,
                              textColor: Colors.white
                          );
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
