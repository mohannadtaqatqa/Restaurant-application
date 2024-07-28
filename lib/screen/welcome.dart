import 'package:flutter/material.dart';
import 'package:foodapp/screen/login.dart';
import 'package:foodapp/screen/signup.dart';
import 'package:get/get.dart';

import '../pizza_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double localeHight = constraints.maxHeight;
            double localeWidth = constraints.maxWidth;
            return SizedBox(
              child: Container(
                
                color: Colors.white,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(fit:  BoxFit.fill,
                        image: const AssetImage('assets/images/welcome.jpeg',),
                        //image: AssetImage('images\lo'),
                        height: localeHight * .4,
                        width: localeWidth * .9,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "تطبيق المطعم",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: localeHight * .01,
                        // height: 10,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        "مرحبا بكم في تطبيقنا الجديد المطعم",
                        style: TextStyle(fontSize: 16,),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            // backgroundColor: Colors.amber,
                            fixedSize: const Size(200.0, 50.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0))),
                        onPressed: () {
                          Get.to(() => const Login());
                        },
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                    SizedBox(height: 20,),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            // backgroundColor: Colors.amber,
                            fixedSize: const Size(200.0, 50.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0))),
                        onPressed: () {
                          Get.to(() => const Signup());
                        },
                        child: const Text(
                          "تسجيل حساب جديد",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Cairo'),
                        ),
                      ),
                  
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
