import 'package:flutter/material.dart';
import 'package:foodapp/screen/otp.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

// تعريف الألوان في أعلى الكود
const Color primaryColor = Color(0xFF0D47A1); // أزرق داكن
const Color accentColor = Color(0xFF1976D2); // أزرق متوسط
const Color textColor = Color(0xFF212121); // نص داكن
const Color backgroundColor = Color(0xFFF5F5F5); // خلفية فاتحة

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _address;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData.latitude != null &&
        _locationData.longitude != null) {
      final latitude = _locationData.latitude!;
      final longitude = _locationData.longitude!;

      // قم بإجراء العملية async في مكان آخر قبل تحديث الحالة
      _fetchAddress(latitude, longitude);
    } else {
      setState(() {
        _address = "Unable to fetch location";
      });
    }
  }

  Future<void> _fetchAddress(double latitude, double longitude) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        latitude,
        longitude,
      );
      if (placemarks.isNotEmpty) {
        geo.Placemark place = placemarks[0];
        setState(() {
          _address = "${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          _address = "Unable to fetch address";
        });
      }
    } catch (e) {
      // setState(() {
        _address = "Error fetching address: $e";
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    // الحصول على حجم الشاشة
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('تسجيل حساب جديد', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05, vertical: screenSize.height * 0.03),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField(
                label: 'الاسم الاول',
                onSaved: (value) => _firstName = value,
              ),
              SizedBox(height: screenSize.height * 0.02),
              _buildTextField(
                label: 'اسم العائلة',
                onSaved: (value) => _lastName = value,
              ),
              SizedBox(height: screenSize.height * 0.02),
              _buildTextField(
                label: 'البريد الإلكتروني',
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value,
              ),
              SizedBox(height: screenSize.height * 0.02),
              _buildTextField(
                label: 'رقم الهاتف',
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phoneNumber = value,
              ),
              SizedBox(height: screenSize.height * 0.02),
              _buildTextField(
                label: 'كلمة المرور',
                obscureText: true,
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: screenSize.height * 0.03),
              Text(
                _address != null
                    ? 'الموقع الحالي: $_address'
                    : 'جارٍ الحصول على الموقع...',
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenSize.height * 0.03),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // قم بإرسال البيانات إلى الخادم أو إجراء آخر هنا
                    Get.to(()=>OTPScreen());
                  }
                },
                child: const Text('تسجيل'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, // لون الخلفية للأزرار
                  foregroundColor: Colors.white, // لون النص للأزرار
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // زوايا دائرية
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02), // مسافة رأسية
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String?> onSaved,
  }) {
    return TextFormField(
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
      onSaved: onSaved,
    );
  }
}
