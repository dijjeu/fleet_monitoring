import 'package:flutter/cupertino.dart';

class UserRepository {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String licenseNumber;
  final String licenseExpiry;
  String? registrationExpiry;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController licenseExpiryController = TextEditingController();

  UserRepository({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.licenseExpiry,
    this.registrationExpiry,
  });
}