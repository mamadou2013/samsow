// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screens/auth.dart';
import '../screens/detail_product.dart';
import '../screens/home.dart';
import '../screens/my_home.dart';
import '../screens/password_reset.dart';
import '../screens/sign_in.dart';
import '../screens/sign_up.dart';
import '../screens/user_advert.dart';
import '../screens/user_home.dart';
import 'auth_guard.dart';

class Routes {
  static const String authentication = '/';
  static const String homePage = '/home-page';
  static const String myHome = '/my-home';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String userHome = '/user-home';
  static const String productDetail = '/product-detail';
  static const String restartPassword = '/restart-password';
  static const String userAdvertisement = '/user-advertisement';
  static const all = <String>{
    authentication,
    homePage,
    myHome,
    signIn,
    signUp,
    userHome,
    productDetail,
    restartPassword,
    userAdvertisement,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.authentication, page: Authentication),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.myHome, page: MyHome, guards: [AuthGuard]),
    RouteDef(Routes.signIn, page: SignIn),
    RouteDef(Routes.signUp, page: SignUp),
    RouteDef(Routes.userHome, page: UserHome, guards: [AuthGuard]),
    RouteDef(Routes.productDetail, page: ProductDetail),
    RouteDef(Routes.restartPassword, page: RestartPassword),
    RouteDef(Routes.userAdvertisement,
        page: UserAdvertisement, guards: [AuthGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    Authentication: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => Authentication(),
        settings: data,
      );
    },
    HomePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    MyHome: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MyHome(),
        settings: data,
      );
    },
    SignIn: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignIn(),
        settings: data,
      );
    },
    SignUp: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUp(),
        settings: data,
      );
    },
    UserHome: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserHome(),
        settings: data,
      );
    },
    ProductDetail: (data) {
      final args = data.getArgs<ProductDetailArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProductDetail(product: args.product),
        settings: data,
      );
    },
    RestartPassword: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RestartPassword(),
        settings: data,
      );
    },
    UserAdvertisement: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserAdvertisement(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProductDetail arguments holder class
class ProductDetailArguments {
  final Product product;
  ProductDetailArguments({@required this.product});
}
