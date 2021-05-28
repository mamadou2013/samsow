import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:samsow/route/auth_guard.dart';
import 'package:samsow/services/advertisement_service.dart';
import 'package:samsow/services/category_service.dart';
import 'package:samsow/services/product_service.dart';
import 'package:samsow/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:samsow/route/router.gr.dart' as router;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppRoot());
}

class MyAppRoot extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final ProductService productService = ProductService();
    final CategoryService categoryService = CategoryService();
    final AdvertisementService advertisementService = AdvertisementService();
    return MultiProvider(
      providers: [
        Provider<UserService>(create: (_) => UserService(),),
        FutureProvider(create: (_) => userService.getCurrentUser()),
        StreamProvider(create: (_) => productService.getAllProducts()),
        StreamProvider(create: (_) => categoryService.getAllCategories()),
        StreamProvider(create: (_) => advertisementService.getAllAdvertisement(),)
      ],
      child: MaterialApp(
       builder: ExtendedNavigator.builder(
         router: router.Router(),
         guards: [AuthGuard()],
         builder: (context, widget) => ResponsiveWrapper.builder(
             BouncingScrollWrapper.builder(context, widget),
             maxWidth: 1200,
             minWidth: 480,
             defaultScale: true,
             breakpoints: [
               ResponsiveBreakpoint.resize(480, name: MOBILE),
               ResponsiveBreakpoint.autoScale(800, name: TABLET),
               ResponsiveBreakpoint.autoScale(1000, name: TABLET),
             ],
             background: Container()
         ),
       ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
