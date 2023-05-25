import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoredValuesPage extends StatefulWidget {
  @override
  _StoredValuesPageState createState() => _StoredValuesPageState();
}

class _StoredValuesPageState extends State<StoredValuesPage> {
  String _phone = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _retrieveStoredValues();
  }

  Future<void> _retrieveStoredValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedPhone = prefs.getString('phone') ?? '';
    String storedPassword = prefs.getString('password') ?? '';

    setState(() {
      _phone = storedPhone;
      _password = storedPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stored Values')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Stored Phone: $_phone'),
            Text('Stored Password: $_password'),
          ],
        ),
      ),
    );
  }
}
