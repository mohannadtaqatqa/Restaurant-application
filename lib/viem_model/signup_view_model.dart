import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/signup_model.dart';

class SignupViewModel {
  int? userType ;
  User _user = User(
    firstName: '',
    lastName: '',
    password: '',
    email: '',
    phoneNumber: '',
    address: '',
  );

  // Getters and setters...
  User get user => _user;
  void setUser(User user) => _user = user;

  String? get firstName => _user.firstName;
  void setFirstName(String? firstName) => _user.firstName = firstName;

  String? get lastName => _user.lastName;  
  void setLastName(String? lastName) => _user.lastName = lastName;

  String? get password => _user.password;
  void setPassword(String? password) => _user.password = password;

  String? get email => _user.email;
  void setEmail(String? email) => _user.email = email;

  String? get phoneNumber => _user.phoneNumber;
  void setPhoneNumber(String? phoneNumber) => _user.phoneNumber = phoneNumber;

  String? get address => _user.address;
  void setAddress(String? address) => _user.address = address;


  void setUserType(int? userType) {
    this.userType = userType;
  }

  // Validate form
  // bool validateForm() {
  //   return _user.firstName.isNotEmpty &&
  //       _user.lastName.isNotEmpty &&
  //       _user.password.isNotEmpty &&
  //       _user.email.isNotEmpty &&
  //       _user.phoneNumber.isNotEmpty &&
  //       validateEmail(_user.email) &&
  //       validatePhoneNumber(_user.phoneNumber) &&
  //       validatePassword(_user.password);
  // }

  // Validate email 
  bool validateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Validate phone number
  bool validatePhoneNumber(String phoneNumber) {
    return RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);
  }

  // Validate password
  bool validatePassword(String password) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password);
  }

  // Obscure Password Toggle
  bool _isObscure = true;
  bool get isObscure => _isObscure;
  void toggleIsObscure() {
    _isObscure = !_isObscure;
  }

  // Register user
  Future<void> registerUser(String id) async {
    // if (!validateForm()) {
    //   print('Validation failed');
    //   return;
    // }
    // print  data
    print(_user.toJson());
    print(_user.firstName);

    try {
      print(id);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/signup/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(_user.toJson()),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('User registered successfully');
      } else {
        // Handle error response
        print('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  setRestaurantName(String? value) {}
}
