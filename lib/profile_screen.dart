import 'package:fleet_monitoring/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home.dart';

class ProfileScreen extends StatefulWidget {
  final UserRepository userRepository;

  const ProfileScreen({
    Key? key,
    required this.userRepository,
  }) : super(key:key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.montserrat(
              fontSize: 35,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Name: ${widget.userRepository.firstName} ${widget.userRepository.lastName}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Phone Number: ${widget.userRepository.phoneNumber}',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'License Number: ${widget.userRepository.licenseNumber}',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'License Expiry: ${widget.userRepository.licenseExpiry}',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate the user to the home page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }
}
