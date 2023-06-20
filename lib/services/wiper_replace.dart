import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WiperReplace extends StatefulWidget {
  @override
  State<WiperReplace> createState() => _WiperReplaceState();
}

class _WiperReplaceState extends State<WiperReplace> {

  //TextEditingController odometerController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  //TextEditingController serviceTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/wiper.png',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 20),
              Text(
                'Wiper Blade Replacement',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.pink[300],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'If you have replaced your wiper blades, please fill up the details to record your parts replacement.',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 20),

              /// -- wiper blade details -- ///
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Where did you purchase this part?'),
              ),
              TextFormField(
                controller: serviceDateController,
                decoration: const InputDecoration(
                  labelText: 'Replacement Date',
                  prefixIcon: Icon(Icons.calendar_month_rounded),
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
                    String formattedDate = DateFormat('MM - dd - yyyy').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      serviceDateController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date of replacement.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              /// -- text buttons -- ///
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Submit')
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}