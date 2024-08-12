import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/core/constant/colors.dart';
import 'package:foodapp/models/login_model.dart';
import 'package:foodapp/view/screen/nav_bar_user.dart';
import 'package:foodapp/view/screen/owner/navbar_owner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../core/constant/endpoints.dart';

class LoginVM {
  final loginModel = LoginModel();
  final formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        final response = await post(
          Uri.parse(loginApi),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'Email': loginModel.emailController.text,
            'Password': loginModel.passwordController.text,
          }),
        );
        print(response.statusCode);

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          responseData['token'] = Jwt.parseJwt(responseData['token']);
          print(responseData['token']);
          if (responseData['userType'] == 1) {
            Get.to(() => const NavBarUser());
          } else if (responseData['userType'] == 2) {
            Get.to(() => const NavBarOwner());
          }
          loginModel.emailController.clear();
          loginModel.passwordController.clear();
        } else {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(
              backgroundColor: red,
              content: Text('البريد الإلكتروني او كلمة السر غير صحيحة'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            backgroundColor: red,
            content: Text('حدث خطا ما'),
          ),
        );
      }
    }
  }
}
