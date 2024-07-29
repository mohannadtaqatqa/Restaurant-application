import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp/controller.dart';
import 'package:foodapp/view/screen/otp.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';

import 'nav_bar_user.dart';
import 'signup.dart';

const Color primaryColor = Color(0xFF0D47A1); // أزرق داكن
const Color accentColor = Color(0xFF1976D2); // أزرق متوسط
const Color textColor = Color(0xFF212121); // نص داكن
const Color backgroundColor = Color(0xFFF5F5F5); // خلفية فاتحة

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.05,
            vertical: screenSize.height * 0.03),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                SizedBox(height: screenSize.height * 0.03),
                _buildLoginForm(),
                SizedBox(height: screenSize.height * 0.03),
                _buildForgotPasswordButton(),
                SizedBox(height: screenSize.height * 0.03),
                _buildLoginButton(),
                SizedBox(height: screenSize.height * 0.02),
                _buildSignUpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
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
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Image.asset('assets/images/pizza-06.png'),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildTextField(
              label: 'البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              // onSaved: (value) => _email = value,
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'كلمة المرور',
              obscureText: true,
              // onSaved: (value) => _password = value,
              controller: _passwordController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Get.to(() => OTPScreen());
      },
      child: Text('نسيت كلمة المرور؟'),
    );
  }

  Widget _buildTextField({
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
        labelStyle: TextStyle(color: primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'يرجى إدخال $label';
      //   }
      //   return null;
      // },
      // onSaved: onSaved,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          final response = await post(
            Uri.parse("http://10.0.2.2:5000/login"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': _emailController.text,
              'password': _passwordController.text,
            }),
          );

          if (response.statusCode == 200) {
            // طلب ناجح
            print('Login successful: ${response.body}');
          } else {
            // طلب فشل
            print('Failed to login: ${response.reasonPhrase}');
          }
        } catch (e) {
          // التعامل مع الأخطاء
          print('Error occurred: $e');
        }
      },
      child: Text('تسجيل الدخول'),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // لون الخلفية للأزرار
        foregroundColor: Colors.white, // لون النص للأزرار
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // زوايا دائرية
        ),
        padding: EdgeInsets.symmetric(vertical: 16), // مسافة رأسية
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSignUpLink() {
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
}
