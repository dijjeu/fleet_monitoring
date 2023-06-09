import 'package:fleet_monitoring/login/complete_profile.dart';
import 'package:fleet_monitoring/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) :super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// -- COMPLETE PROFILE DETAILS -- ///
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController licenseNumController = TextEditingController();
  final TextEditingController licenseExpController = TextEditingController();

  @override
  void initState() {
    licenseNumController.text = ""; //set the initial value of text field
    super.initState();
  }

  // define and initialize the obscureText variable
  bool _obscureText = true;

  String message = '';

  Future<void> _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = phoneController.text;
    String password = passwordController.text;

    if (phone.isNotEmpty && password.isNotEmpty) {
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);

      setState(() {
        message = 'Registration successful!';
      });
    } else {
      setState(() {
        message = 'Please enter both phone and password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/trucks.png', height: 150),
                  const SizedBox(height: 20),
                  Text(
                    'Create an Account',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  /// -- phone number input
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),

                  /// -- password input
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password_outlined),
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                  ),

                  /// -- confirm password input
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon:
                      const Icon(Icons.password_outlined),
                      labelText: 'Confirm Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the confirmation password';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// -- login button
                  ElevatedButton(
                    onPressed: () {
                      _register();
                      if (_formKey.currentState!.validate()) {
                        // Navigate the user to the complete profile page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteProfile(
                              firstName: fnameController.text,
                              lastName: lnameController.text,
                              phoneNumber: phoneController.text,
                              licenseNumber: licenseNumController.text,
                              licenseExpiry: licenseExpController.text,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all<Color?>(Colors.black54),
                      backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                        ),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),

                  /// -- create an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String licenseNumber;
  final String licenseExpiry;

  const CompleteProfile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.licenseExpiry,
  }) : super(key: key);

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;
  String? _phoneNumber;
  final TextEditingController licenseNumController = TextEditingController();
  final TextEditingController licenseExpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    _phoneNumber = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // -- header 'complete your profile' -- //
                  Image.asset('assets/license.png', height: 150),
                  const SizedBox(height: 20),
                  Text(
                    'Complete your profile',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  /// -- FIRST name input
                  TextFormField(
                    initialValue: _firstName,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _firstName = value;
                      });
                    },
                  ),

                  /// -- LAST name input
                  TextFormField(
                    initialValue: _lastName,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _lastName = value;
                      });
                    },
                  ),

                  /// -- Phone number input
                  TextFormField(
                    initialValue: _phoneNumber,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),

                  /// -- driver's license number input
                  TextFormField(
                    controller: licenseNumController,
                    decoration: const InputDecoration(
                      labelText: 'Driver\'s License Number',
                      prefixIcon: Icon(Icons.numbers_rounded),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your driver\'s license number.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: licenseExpController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month_rounded),
                      labelText: 'Enter Driver\'s License Expiry',
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101)
                      );
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                        print(formattedDate);
                        setState(() {
                          licenseExpController.text = formattedDate;
                        });
                      } else {
                        print('Date is not selected');
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your driver\'s license expiry date.';
                      }
                      return null;
                    },
                  ),


                  const SizedBox(height: 20),

                  /// -- complete profile button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate the user to the home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signup successful!'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields'),
                          ),
                        );
                      }
                    },
                    child: const Text('Complete Profile'),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

