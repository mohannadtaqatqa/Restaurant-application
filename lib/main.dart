import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'screen/welcome.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ar'),
      title: 'Flutter Food App UI',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      // home: PizzaScreen(),
      home:const Welcome()
    );
  }
}
