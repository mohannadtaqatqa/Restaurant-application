import 'package:flutter/material.dart';
import 'package:foodapp/viem_model/otp_viewmodel.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key,required this.email});
  final String email;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OTPViewModel viewModel = Get.put(OTPViewModel());
  final Color primaryColor = Colors.blue[900]!;
  final Color secondaryColor = Colors.blueAccent;
  final Color white = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تأكيد البريد الإلكتروني', style: TextStyle(color: white)),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'أدخل رمز التحقق المرسل إلى بريدك الإلكتروني',
                      style: TextStyle(fontSize: 18, color: primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    _buildPinCodeFields(constraints),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.verifyOTP(widget.email);
                          // if (isVerified) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('OTP Verified!')),
                          //   );
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Invalid OTP!')),
                          //   );
                          // }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('تأكيد', style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // إعادة إرسال رمز التحقق
                      },
                      child: Text(
                        'إعادة إرسال رمز التحقق',
                        style: TextStyle(
                          color: secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeFields(BoxConstraints constraints) {
    double fieldWidth = constraints.maxWidth > 400 ? 60 : 50;
    double fieldHeight = constraints.maxWidth > 400 ? 60 : 50;
    return PinCodeTextField(
      appContext: context,
      length: 4, // عدد الأرقام في رمز التحقق
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box, // الشكل هنا box بدلاً من underline
        borderRadius: BorderRadius.circular(10),
        fieldHeight: fieldHeight,
        fieldWidth: fieldWidth,
        activeFillColor: white,
        inactiveFillColor: white,
        selectedFillColor: white,
        activeColor: primaryColor,
        inactiveColor: primaryColor.withOpacity(0.5), // لون غير نشط مع شفافية
        selectedColor: secondaryColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: viewModel.otpController,
      onCompleted: (value) {
        // setCodeOtpModel
        print("value is $value");
        print("controller is ${viewModel.otpController.text}");
        print("inputted otp is ${viewModel.otpController.text}");
      },
      onChanged: (value) {
        // معالجة عند تغيير القيمة
      },
      beforeTextPaste: (text) {
        // السماح بلصق النص
        return true;
      },
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 4) {
          return 'يرجى إدخال رمز تحقق صحيح';
        }
        return null;
      },
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
