import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/home_screen.dart';
import 'package:trailset_route_optimize/utils/utils.dart';

void main() {
  VariableUtilities.theme = LightTheme();
  runApp(const TrailsetRouteOptimizeApp());
}

class TrailsetRouteOptimizeApp extends StatelessWidget {
  const TrailsetRouteOptimizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    VariableUtilities.screenSize = MediaQuery.of(context).size;

    return MultiProvider(
      providers: ProviderBind.providers,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

