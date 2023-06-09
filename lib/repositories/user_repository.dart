class UserRepository {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String licenseNumber;
  final String licenseExpiry;

  UserRepository({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.licenseExpiry,
  });
}