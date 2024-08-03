import 'package:flutter/material.dart';
import '../../core/constant/colors.dart';
import '../../viem_model/check_email_viewmodel.dart';

class EmailInputView extends StatefulWidget {
  const EmailInputView({super.key});

  @override
  _EmailInputViewState createState() => _EmailInputViewState();
}

class _EmailInputViewState extends State<EmailInputView> {
  final CheckEmailViewModel viewModel = CheckEmailViewModel();
  bool _isLoading = false;
  bool _isEmailValid = false;

  void _updateEmail(String email) {
    setState(() {
      _isEmailValid = email.contains('@') && email.contains('.');
    });
  }

  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    await viewModel.emailIsValid();
    // إضافة منطق إرسال OTP هنا إذا كان البريد الإلكتروني صالحًا
    if (viewModel.isEmailExist.value) {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة تأخير الشبكة
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    viewModel.checkEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('استعادة كلمة المرور', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImage(screenSize),
                  SizedBox(height: screenSize.height * 0.09),
                  _buildEmailField(screenSize),
                  SizedBox(height: screenSize.height * 0.03),
                  _buildSendOTPButton(screenSize),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(Size screenSize) {
    final imageSize = screenSize.width * 0.6;
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/forgetpass.jpg',
        height: imageSize,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEmailField(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      child: TextField(
        controller: viewModel.checkEmailController,
        decoration: InputDecoration(
          labelText: 'ادخل بريدك الالكتروني',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: textFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: textFieldBorderColor),
          ),
          labelStyle: const TextStyle(color: textColor),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          _updateEmail(value);
        },
      ),
    );
  }

  Widget _buildSendOTPButton(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.5,
      child: ElevatedButton(
        onPressed: _isEmailValid
            ? () {
                _sendOTP();
              }
            : null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(160, 50),
          backgroundColor: primaryColor,
          foregroundColor: buttonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text('ارسال'),
      ),
    );
  }
}
