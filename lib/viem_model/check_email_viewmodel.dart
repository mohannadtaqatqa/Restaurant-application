
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../view/screen/otp.dart';

class CheckEmailViewModel extends GetxController {
  TextEditingController checkEmailController = TextEditingController();
  RxBool isEmailExist = false.obs;

  Future<void> emailIsValid() async {
    print("${checkEmailController.text}");
    final response = await http.get(Uri.parse(
        "http://10.0.2.2:5000/check_Email/${checkEmailController.text}"));
    if (response.statusCode == 200) {
      isEmailExist.value = true;
      Get.to(() => OTPScreen(email: checkEmailController.text));
    } else if (response.statusCode == 404) {
      isEmailExist.value = false;
      Get.snackbar("خطا", "البريد الالكتروني غير صحيح");
    } else {
      print(response.body);
      Get.snackbar("${response.body}", "حدث خطأ ما");
    }
  }
}
