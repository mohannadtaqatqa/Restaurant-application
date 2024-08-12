import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'view/screen/welcome.dart';

void main() {
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
        fontFamily: 'Cairo',
        appBarTheme: const AppBarTheme(
            elevation: 0, backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home:const Welcome()
    );
  }
}
