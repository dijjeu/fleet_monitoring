import 'package:fleet_monitoring/home.dart';
import 'package:fleet_monitoring/login/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) :super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _message = '';

  bool _obscureText = true;

  Future<void> _login() async {
    String phone = phoneController.text;
    String password = passwordController.text;

    String? loggedInUser = await Authentication.login(phone, password);

    if (loggedInUser != null) {
      setState(() {
        _message = 'Login successful!';
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInUser', loggedInUser);

      // Navigate to the desired screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      setState(() {
        _message = 'Invalid phone number or password.';
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
                    'Login',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_outlined),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                        //_login();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete all fields'),
                          ),
                        );
                      }
                    },
                    child: const Text('Login'),
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all<Color?>(Colors.black54),
                      backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // Adjust the value as needed
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New User?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Register()),
                          );
                        },
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(_message),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
