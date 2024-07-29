import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String firstName;
  String lastName;
  String password;
  String email;
  String phoneNumber;

  User({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'password': password,
    'email': email,
    'phoneNumber': phoneNumber,
  };
}

class SignupViewModel {
  User _user = User(
    firstName: '',
    lastName: '',
    password: '',
    email: '',
    phoneNumber: '',
  );

  // Getters and setters...
  User get user => _user;
  void setUser(User user) => _user = user;

  // Getters and setters...
  String get firstName => _user.firstName;
  void setFirstName(String firstName) => _user.firstName = firstName;

  String get lastName => _user.lastName;  
  void setLastName(String lastName) => _user.lastName = lastName;

  String get password => _user.password;
  void setPassword(String password) => _user.password = password;

  String get email => _user.email;
  void setEmail(String email) => _user.email = email;

  String get phoneNumber => _user.phoneNumber;
  void setPhoneNumber(String phoneNumber) => _user.phoneNumber = phoneNumber;

  // Validate form
  bool validateForm() {
    return _user.firstName.isNotEmpty &&
        _user.lastName.isNotEmpty &&
        _user.password.isNotEmpty &&
        _user.email.isNotEmpty &&
        _user.phoneNumber.isNotEmpty;
  }

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
  Future<void> registerUser() async {
    final url = Uri.parse('https://example.com/api/register');
    final response = await http.post(
      url,
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
  }
}
