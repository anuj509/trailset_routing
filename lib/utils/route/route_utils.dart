import 'package:flutter/material.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/home_screen.dart';


/// Manage all the routes used in the application.
class RouteUtilities {
  /// first screen to open in the application.
  static const String root = '/';

  /// On boarding screen.
  static const String onBoardingScreen = '/onBoardingScreen';

  /// home screen.
  static const String homeScreen = '/homeScreen';

  /// we are using named route to navigate to another screen,
  /// and while redirecting to the next screen we are using this function
  /// to pass arguments and other routing things..
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteUtilities.root;

    /// this is the instance of arguments to pass data in other screens.
    dynamic arguments = settings.arguments;
    switch (routeName) {
      case RouteUtilities.root:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RouteUtilities.homeScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
    }
  }
}
