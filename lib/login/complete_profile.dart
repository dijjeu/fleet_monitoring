import 'package:fleet_monitoring/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();

  //final TextEditingController _phoneController = TextEditingController();
  final TextEditingController licenseNumController = TextEditingController();
  //DateTime _licenseExpDate = DateTime.now();
  final TextEditingController licenseExpController = TextEditingController();
  //final TextEditingController _licenseCodeController = TextEditingController();



  /*Future<void> _selectLicenseExpDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) {
      final TimeOfDay? timePicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (timePicked != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
        );
        setState(() {
          _licenseExpDate = selectedDateTime;
          _licenseExpController.text = selectedDateTime.toString(); // Update the text field with the selected date and time
        });
      }
    }
  }*/

  @override
  void initState() {
    licenseNumController.text = ""; //set the initial value of text field
    super.initState();
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
                  Text(
                    'Complete your profile',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.pink[300],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  /// -- FIRST name input
                  TextFormField(
                    controller: fnameController,
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
                  ),

                  /// -- LAST name input
                  TextFormField(
                    controller: lnameController,
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
                        String formattedDate = DateFormat('yyyy - MM - dd').format(pickedDate);
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
                        if(_formKey.currentState!.validate()) {
                          // Navigate the user to the home page
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Signup successful!')
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
                      child: const Text('Login')
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