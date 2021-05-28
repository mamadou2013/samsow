
import 'package:auto_route/auto_route_annotations.dart';
import 'package:samsow/route/auth_guard.dart';
import 'package:samsow/screens/auth.dart';
import 'package:samsow/screens/detail_product.dart';
import 'package:samsow/screens/home.dart';
import 'package:samsow/screens/my_home.dart';
import 'package:samsow/screens/password_reset.dart';
import 'package:samsow/screens/sign_in.dart';
import 'package:samsow/screens/sign_up.dart';
import 'package:samsow/screens/user_advert.dart';
import 'package:samsow/screens/user_home.dart';

@MaterialAutoRouter(
    routes: <AutoRoute>[
      MaterialRoute(page: Authentication, initial: true),
      MaterialRoute(page: HomePage),
      MaterialRoute(page: MyHome, guards: [AuthGuard]),
      MaterialRoute(page: SignIn),
      MaterialRoute(page: SignUp),
      MaterialRoute(page: UserHome, guards: [AuthGuard]),
      MaterialRoute(page: ProductDetail),
      MaterialRoute(page: RestartPassword),
      MaterialRoute(page: UserAdvertisement, guards: [AuthGuard]),
    ])
class $Router{}