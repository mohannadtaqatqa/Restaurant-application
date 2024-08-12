import 'package:flutter/material.dart';
import '../../core/constant/colors.dart';
import '../../core/fun/feach_address.dart';
import '../../viem_model/signup_view_model.dart';
import '../widget/fields_signup.dart';

// تعريف الألوان في أعلى الكود

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();



  final SignupViewModel viewModel = SignupViewModel();
  late Future<String?> _addressFuture;
  @override
  void initState() {
    super.initState();
   _addressFuture = getLocation();
  }



  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل حساب جديد', style: TextStyle(color: Colors.white)),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildTextField(
                label: 'الاسم الاول',
                onChange: (value) => viewModel.setFirstName(value),
              ),
              SizedBox(height: screenSize.height * 0.02),
              buildTextField(
                label: 'اسم العائلة',
                onChange: (value) => viewModel.setLastName(value),
              ),
              SizedBox(height: screenSize.height * 0.02),
              buildTextField(
                label: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
                onChange: (value) => viewModel.setEmail(value),
              ),
              SizedBox(height: screenSize.height * 0.02),
              buildTextField(
                label: 'رقم الهاتف',
                keyboardType: TextInputType.phone,
                onChange: (value) => viewModel.setPhoneNumber(value),
              ),
              SizedBox(height: screenSize.height * 0.02),
              buildTextField(
                label: 'كلمة المرور',
                obscureText: true,
                onChange: (value) => viewModel.setPassword(value),
              ),
              SizedBox(height: screenSize.height * 0.02),
              buildDropdownField(
                  label: "نوع المستخدم",
                  value: "يرجى الاختيار",
                  items: ["يرجى الاختيار", "عميل", "صاحب المطعم","توصيل"],
                  onChanged: (value) {
                    viewModel.setUserType(["يرجى الاختيار", "عميل", "صاحب المطعم","توصيل"].indexOf(value!));
                  }),
              SizedBox(height: screenSize.height * 0.02),
              if (viewModel.userType == 2) ...[
                buildTextField(
                  label: "اسم المطعم",
                  onChange: (value) => viewModel.setRestaurantName(value),
                ),
                SizedBox(height: screenSize.height * 0.02),
                buildTextField(
                  label: "موقع المطعم",
                  onChange: (value) => "viewModel.setRestaurantLocation(value)",
                ),
                SizedBox(height: screenSize.height * 0.03),
              ],
              SizedBox(height: screenSize.height * 0.03),
               FutureBuilder<String?>(
                future: _addressFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'جارٍ الحصول على الموقع...',
                      style:  TextStyle(fontSize: 16, color: textColor),
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'خطأ في الحصول على الموقع: ${snapshot.error}',
                      style: const TextStyle(fontSize: 16, color: textColor),
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    viewModel.setAddress(snapshot.data!);
                    return Text(
                      'الموقع الحالي: ${snapshot.data}',
                      style: const TextStyle(fontSize: 16, color: textColor),
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return const Text(
                      'لم يتمكن من الحصول على الموقع',
                      style: TextStyle(fontSize: 16, color: textColor),
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
              SizedBox(height: screenSize.height * 0.03),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // قم بإرسال البيانات إلى الخادم أو إجراء آخر هنا
                    viewModel.registerUser(viewModel.userType.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // لون الخلفية للأزرار
                  foregroundColor: Colors.white, // لون النص للأزرار
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // زوايا دائرية
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02), // مسافة رأسية
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text('تسجيل'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

