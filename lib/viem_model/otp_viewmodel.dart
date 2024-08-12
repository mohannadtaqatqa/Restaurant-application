import 'package:flutter/material.dart';
import 'package:foodapp/core/constant/endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class OTPViewModel {
  // CodeOtpModel codeOtpModel = CodeOtpModel(otpController: TextEditingController());
  final otpController = TextEditingController();

  // CodeOtpModel getCodeOtpModel() => codeOtpModel;


  verifyOTP(String email) async {
    // في تطبيق حقيقي، قد ترغب في التحقق من OTP من خلال خادم
    final res = await post(
        Uri.parse(verifyEmailApi),
        body: {"code": otpController.text, "Email": email});

    print(email);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text("تم التسجيل بنجاح"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ));
      Get.to(() => const Text("تم التسجيل بنجاح"));
    }
    
  }
}
