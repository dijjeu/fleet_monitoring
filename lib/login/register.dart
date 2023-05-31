import 'package:fleet_monitoring/login/complete_profile.dart';
import 'package:fleet_monitoring/login/login.dart';
import 'package:fleet_monitoring/login/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) :super(key: key);

  @override
  State<Register> createState() => _RegisterState();

}

class _RegisterState extends State<Register>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // define and initialize the obscureText variable
  bool _obscureText = true;

  String _message = '';

  Future<void> _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = phoneController.text;
    String password = passwordController.text;

    if (phone.isNotEmpty && password.isNotEmpty) {
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);

      setState(() {
        _message = 'Registration successful!';
      });
    } else {
      setState(() {
        _message = 'Please enter both phone and password.';
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
                        if(_formKey.currentState!.validate()) {
                          // Navigate the user to the home page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfile()));
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: const Text('Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
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