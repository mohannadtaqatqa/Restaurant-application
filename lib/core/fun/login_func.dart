
  import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../view/screen/check_email.dart';
import '../../view/screen/signup.dart';
import '../constant/colors.dart';

Widget buildLogo() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Image.asset('assets/images/pizza-06.png'),
      ),
    );
  }

  Widget buildLoginForm(vm) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: vm.formKey,
        child: Column(
          children: <Widget>[
            buildTextField(
              label: 'البريد الإلكتروني',
              
              keyboardType: TextInputType.emailAddress,
              controller: vm.loginModel.emailController,
            ),
            const SizedBox(height: 16),
            buildTextField(
              label: 'كلمة المرور',
              obscureText: true,
              controller: vm.loginModel.passwordController,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Get.to(() => const EmailInputView());
      },
      child: const Text('نسيت كلمة المرور؟', style: TextStyle(color: primaryColor)),
    );
  }

  Widget buildTextField({
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: textColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال $label';
        }
        return null;
      },
    );
  }

  Widget buildLoginButton(vm) {
    return ElevatedButton(
      onPressed: vm.login,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 50),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: const Text('تسجيل الدخول',style: TextStyle(color: Colors.white,fontFamily: "Cairo"),),
    );
  }

  Widget buildSignUpLink() {
    return TextButton(
      onPressed: () {
        Get.to(() => const Signup());
      },
      child: const Text(
        'ليس لديك حساب؟ تسجيل جديد',
        style: TextStyle(color: primaryColor),
      ),
    );
  }
