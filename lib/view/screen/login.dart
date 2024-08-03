import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import '../../core/constant/colors.dart';
import 'check_email.dart';
import 'signup.dart';

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
        title: const Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
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
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'كلمة المرور',
              obscureText: true,
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
        Get.to(() => EmailInputView());
      },
      child: Text('نسيت كلمة المرور؟', style: TextStyle(color: primaryColor)),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال $label';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
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
        }
      },
      child: Text('تسجيل الدخول'),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
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
