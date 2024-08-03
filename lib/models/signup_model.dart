class User {
  String? firstName;
  String? lastName;
  String? password;
  String? email;
  String? phoneNumber;
  String? address;

  User({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address
      };
}

// }
