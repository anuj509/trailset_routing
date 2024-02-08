import 'package:trailset_route_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

/// This class manage all the provider and return list of provider.
class ProviderBind {
  /// This is the list of providers to manage and attache with application.
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
  ];
}
