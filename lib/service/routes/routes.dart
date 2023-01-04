import 'package:flutter/cupertino.dart';

import '../../view/screens/auth_screen/auth_screen.dart';
import '../../view/screens/details_screen/details_screen.dart';
import '../../view/screens/home_screen/home_screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  AuthScreen.routeName: (context) => AuthScreen(),
};
