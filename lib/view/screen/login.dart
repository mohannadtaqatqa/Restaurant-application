import 'package:flutter/material.dart';
import '../../core/constant/colors.dart';
import '../../core/fun/login_func.dart';
import '../../viem_model/login_vm.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final vm = LoginVM();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('تسجيل الدخول', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                buildLogo(),
                SizedBox(height: screenSize.height * 0.03),
                buildLoginForm(vm),
                SizedBox(height: screenSize.height * 0.03),
                buildForgotPasswordButton(),
                SizedBox(height: screenSize.height * 0.03),
                buildLoginButton(vm),
                SizedBox(height: screenSize.height * 0.02),
                buildSignUpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
