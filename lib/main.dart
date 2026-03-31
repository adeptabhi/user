import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/local_db/db.dart';
import 'package:user/routes/routes.dart';
import 'package:user/routes/routes_name.dart';
import 'package:user/util/theme/theme_app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await DB.inst.openDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'User',
      theme: ThemeApp.light,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: RoutesName.user,
    );
  }
}
