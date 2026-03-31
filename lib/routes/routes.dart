import 'package:adept_log/view/adept_log.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user/module/user/model/user_mdl.dart';
import 'package:user/module/user/provider/user_provider.dart';
import 'package:user/module/user/view/user_view.dart';
import 'package:user/module/user_detail/view/user_detail.dart';
import 'package:user/routes/routes_name.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    AdeptLog.i(
      'Route: ${settings.name}'
      '${settings.arguments != null ? ' | Args: ${settings.arguments}' : ''}',
      tag: 'Route',
    );
    switch (settings.name) {
      case RoutesName.user:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider(
                create: (context) => UserProvider(context: context),
                child: UserView(),
              ),
        );

      case RoutesName.userDetail:
        return PageRouteBuilder(
          settings: RouteSettings(name: settings.name),
          pageBuilder: (context, animation, secondaryAnimation) =>
              UserDetailView(user: settings.arguments as UserMdl),
        );
    }
    return null;
  }
}
