import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:trailset_route_optimize/mvp/src/home/view/home_screen.dart';
import 'package:trailset_route_optimize/utils/utils.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

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

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textEditingController = TextEditingController();
  late PickerMapController controller = PickerMapController(
    initMapWithUserPosition: const UserTrackingOption(),
  );

  @override
  void initState() {
    MapController controller = MapController(
      initMapWithUserPosition: const UserTrackingOption(),
    );

    super.initState();
    textEditingController.addListener(textOnChanged);
  }

  void textOnChanged() {
    controller.setSearchableText(textEditingController.text);
  }

  @override
  void dispose() {
    textEditingController.removeListener(textOnChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PointerInterceptor(
        child: InkWell(
          onTap: () {},
          child: CustomPickerLocation(
            controller: controller,
            topWidgetPicker: Padding(
              padding: const EdgeInsets.only(
                top: 56,
                left: 8,
                right: 8,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      PointerInterceptor(
                        child: TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      Expanded(
                        child: PointerInterceptor(
                          child: TextField(
                            controller: textEditingController,
                            onEditingComplete: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              suffix: ValueListenableBuilder<TextEditingValue>(
                                valueListenable: textEditingController,
                                builder: (ctx, text, child) {
                                  if (text.text.isNotEmpty) {
                                    return child!;
                                  }
                                  return const SizedBox.shrink();
                                },
                                child: InkWell(
                                  focusNode: FocusNode(),
                                  onTap: () {
                                    textEditingController.clear();
                                    controller.setSearchableText("");
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              focusColor: Colors.black,
                              filled: true,
                              hintText: "search",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              fillColor: Colors.grey[300],
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            bottomWidgetPicker: Positioned(
              bottom: 12,
              right: 8,
              child: PointerInterceptor(
                child: FloatingActionButton(
                  onPressed: () async {
                    GeoPoint p =
                        await controller.selectAdvancedPositionPicker();
                    Navigator.pop(context, p);
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
            pickerConfig: const CustomPickerLocationConfig(
              loadingWidget: CircularProgressIndicator(),
              zoomOption: ZoomOption(
                initZoom: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
