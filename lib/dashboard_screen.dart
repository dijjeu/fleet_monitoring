import 'package:fleet_monitoring/login/login.dart';
import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:fleet_monitoring/vehicle/vehicle_entry.dart';
import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({Key? key,}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  /// NOTIFICATION PLUGIN
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// CAROUSEL SLIDER
  late PageController _pageController = PageController();
  int pageNum = 0;
  List<VehicleDetails> vehicleDetails = List.empty(growable: true);

  /// VEHICLE DETAILS
  TextEditingController carMakeController = TextEditingController();
  TextEditingController yearModelController = TextEditingController();
  TextEditingController plateNumController = TextEditingController();
  TextEditingController colorController = TextEditingController();


  /// REGISTRATION DETAILS
  TextEditingController regisNumController = TextEditingController();
  TextEditingController orNumController = TextEditingController();
  TextEditingController regisDateController = TextEditingController();
  TextEditingController regisExpController = TextEditingController();
  TextEditingController orDateIssuedController = TextEditingController();

  List<VehicleDetails> allVehicles = List.empty(growable: true);

  int selectedIndex = -1;


  @override
  void initState() {
    super.initState();
    // -- notification
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // -- carousel
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    carMakeController.dispose();
    yearModelController.dispose();
    plateNumController.dispose();
    super.dispose();
  }

  void addVehicle() {
    String carMake = carMakeController.text.trim();
    String yearModel = yearModelController.text.trim();
    String color = colorController.text.trim();
    String plateNum = plateNumController.text.trim();

    String regisNum = regisNumController.text.trim();
    String regisDate = regisDateController.text.trim();
    String regisExp = regisExpController.text.trim();
    String orNum = orNumController.text.trim();
    String orDateIssued = orDateIssuedController.text.trim();

    if (carMake.isNotEmpty && yearModel.isNotEmpty &&
        color.isNotEmpty && plateNum.isNotEmpty &&
        regisNum.isNotEmpty && regisDate.isNotEmpty &&
        regisExp.isNotEmpty && orNum.isNotEmpty && orDateIssued.isNotEmpty) {
      setState(() {
        VehicleDetails newVehicle = VehicleDetails(
          carMake: carMake,
          color: color,
          yearModel: yearModel,
          plateNum: plateNum,
          regisNum: regisNum,
          orNum: orNum,
          regisDate: regisDate,
          regisExp: regisExp,
          orDateIssued: orDateIssued,
        );
        vehicleDetails.add(newVehicle);
        allVehicles.add(newVehicle);
      });

      carMakeController.text = '';
      yearModelController.text = '';
      colorController.text = '';
      plateNumController.text = '';

      regisNumController.text = '';
      regisDateController.text = '';
      regisExpController.text = '';
      orNumController.text = '';
      orDateIssuedController.text = '';

      Navigator.pop(context);

      _pageController.animateToPage(vehicleDetails.length - 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void onDidReceiveNotificationResponse(
      String? payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => NotificationScreen(payload)),
      );
    }
  }

  Future<void> _showNotification(String title, String message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, message, notificationDetails,
        payload: 'item x');
  }

  /*final payload = 'This is a sample payload';
            _showNotification('Hello', 'This is a sample notification');
            onDidReceiveNotificationResponse(payload, context);
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Home',
                    style: GoogleFonts.montserrat(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 170),
                  GestureDetector(
                    child: Icon(Icons.logout_rounded),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              searchBar(),
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageNum = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: Container(
                        child: Image.asset('assets/delivery-truck.png', fit: BoxFit.fitWidth,),
                        margin: const EdgeInsets.only(
                          right: 4,
                          left: 4,
                          top: 36,
                          bottom: 12,
                        ),
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.transparent,
                        ),
                      ),
                    );
                  },
                  itemCount: vehicleDetails.length,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(vehicleDetails.length, (index) {
                  return Container(
                    margin: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: pageNum == index ? Colors.blue[800] : Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              if (vehicleDetails.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        vehicleDetails[pageNum].plateNum,
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            vehicleDetails[pageNum].carMake,
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            vehicleDetails[pageNum].yearModel,
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VehicleEntry(vehicle: vehicleDetails[pageNum])),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.info_outline_rounded, color: Colors.black87),
                                SizedBox(width: 8),
                                Text('Information'),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.edit_note_outlined, color: Colors.black87),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          )

                        ],
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: vehicleInput(),
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add a new vehicle'),
                    const SizedBox(width: 50),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
                style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewAllVehicles()));
                },
                child: Text('View all vehicles'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    String searchText = '';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget regisExpiry() {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: Table(
                defaultColumnWidth: FixedColumnWidth(120),
                border: TableBorder.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                  width: 1,
                ),
                children: [
                  TableRow(children: [
                    Column(children: [
                      Text(
                        'Last Digit of Plate Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        'Month',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ]),
                  TableRow(
                      children: [
                        Column(children: [Text('1')]),
                        Column(children: [Text('January')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('2')]),
                        Column(children: [Text('February')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('3')]),
                        Column(children: [Text('March')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('4')]),
                        Column(children: [Text('April')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('5')]),
                        Column(children: [Text('May')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('6')]),
                        Column(children: [Text('June')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('7')]),
                        Column(children: [Text('July')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('8')]),
                        Column(children: [Text('August')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('9')]),
                        Column(children: [Text('September')]),
                      ]
                  ),
                  TableRow(
                      children: [
                        Column(children: [Text('0')]),
                        Column(children: [Text('October')]),
                      ]
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1,
              ),
              children: [
                TableRow(
                    children: [
                      Column(children: [Text('2nd to the last digit of plate number')]),
                      Column(children: [Text('Week')]),
                    ]
                ),
                TableRow(
                    children: [
                      Column(children: [Text('1, 2, 3')]),
                      Column(children: [Text('1st to 7th Working Day')]),
                    ]
                ),
                TableRow(
                    children: [
                      Column(children: [Text('4, 5, 6')]),
                      Column(children: [Text('8th to 14th Working Day')]),
                    ]
                ),
                TableRow(
                    children: [
                      Column(children: [Text('7, 8')]),
                      Column(children: [Text('15th to 21st Working Day')]),
                    ]
                ),
                TableRow(
                    children: [
                      Column(children: [Text('9, 0')]),
                      Column(children: [Text('22nd to the last Working Day')]),
                    ]
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget vehicleInput() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20),
            /// -- registration details -- ///
            Text(
              'Vehicle Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            TextField(
              controller: carMakeController,
              decoration: const InputDecoration(labelText: 'Car Make'),
            ),
            TextField(
              controller: yearModelController,
              decoration: const InputDecoration(labelText: 'Year Model'),
            ),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            TextField(
              controller: plateNumController,
              decoration: const InputDecoration(labelText: 'Plate Number'),
            ),
            const SizedBox(height: 20),
            /// -- registration details -- ///
            Text(
              'Registration Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            TextField(
              controller: regisNumController,
              decoration:
              const InputDecoration(labelText: 'Registration Number'),
            ),
            TextFormField(
              controller: regisDateController,
              decoration: const InputDecoration(
                labelText: 'Registration Date',
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
                  String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    regisDateController.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the registration date.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: regisExpController,
              decoration: InputDecoration(
                labelText: 'Registration Expiry',
                prefixIcon: Icon(Icons.calendar_month_rounded),
                suffixIcon: GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'LTO Vehicle Registration Renewal Schedule',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        content: regisExpiry(),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Back'),
                          ),
                        ],
                      );
                    });
                  },
                  child: Icon(Icons.help_outline_rounded),
                ),
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
                    regisExpController.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the registration expiry.';
                }
                return null;
              },
            ),
            TextField(
              controller: orNumController,
              decoration: const InputDecoration(labelText: 'OR Number'),
            ),
            TextFormField(
              controller: orDateIssuedController,
              decoration: const InputDecoration(
                labelText: 'OR Date Issued',
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
                  String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    orDateIssuedController.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the registration date.';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.red[400],
                    ),
                  ),
                  onPressed: addVehicle,
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget viewAllVehicles() {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            Text(
              'All Vehicles',
              style: GoogleFonts.montserrat(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allVehicles.length,
                itemBuilder: (context, index) {
                  VehicleDetails vehicle = allVehicles[index];
                  return Card(
                    child: ListTile(
                      title: Text(vehicle.plateNum),
                      subtitle: Text(vehicle.carMake),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back')
            ),
          ],
        ),
      ),
    );
  }

}