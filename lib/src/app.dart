import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:headphones_app/src/overview/presentation/overview_screen.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    setOptimalDisplayMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 0, 195, 254),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 0, 195, 254),
      ),
      home: const OverviewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> setOptimalDisplayMode() async {
    List<DisplayMode> supportedModes = <DisplayMode>[];

    try {
      supportedModes = await FlutterDisplayMode.supported;
    } on PlatformException {
      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background.
    }

    final DisplayMode active = await FlutterDisplayMode.active;

    final List<DisplayMode> sameResolution = supportedModes
        .where(
          (DisplayMode m) =>
              m.width == active.width && m.height == active.height,
        )
        .toList()
      ..sort(
        (DisplayMode a, DisplayMode b) =>
            b.refreshRate.compareTo(a.refreshRate),
      );

    final DisplayMode mostOptimalMode =
        sameResolution.isNotEmpty ? sameResolution.first : active;

    await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
  }
}
