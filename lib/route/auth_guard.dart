import 'package:auto_route/auto_route.dart';
import 'package:samsow/services/user_service.dart';

class AuthGuard extends RouteGuard{
  @override
  Future<bool> canNavigate(ExtendedNavigatorState<RouterBase> navigator, String routeName, Object arguments) async {
     final isLoggedIn = await UserService().isLoggedIn();
     return !isLoggedIn;
  }
}