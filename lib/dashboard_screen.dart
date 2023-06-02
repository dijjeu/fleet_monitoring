import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle/vehicle.dart';
import 'package:fleet_monitoring/vehicle/vehicle_entry.dart';
import 'package:fleet_monitoring/vehicle_input.dart';
import 'package:fleet_monitoring/vehicle_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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

  /// VEHICLE DETAILS DISPLAY
  TextEditingController carMakeController = TextEditingController();
  TextEditingController yearModelController = TextEditingController();
  TextEditingController plateNumController = TextEditingController();

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
    String plateNum = plateNumController.text.trim();

    if (carMake.isNotEmpty && yearModel.isNotEmpty && plateNum.isNotEmpty) {
      setState(() {
        vehicleDetails.add(VehicleDetails(
          carMake: carMake,
          yearModel: yearModel,
          plateNum: plateNum,
          color: '', regisNum: '', orNum: '', regisDate: '', orDateIssued: '',
        ));
      });

      carMakeController.text = '';
      yearModelController.text = '';
      plateNumController.text = '';
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
              const SizedBox(height: 20),
              Text(
                'Home',
                style: GoogleFonts.montserrat(
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text('View all vehicles'),
              ),
              const SizedBox(height: 20),
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
                        child: Image.asset('assets/license.png'),
                        margin: const EdgeInsets.only(
                          right: 4,
                          left: 4,
                          top: 36,
                          bottom: 12,
                        ),
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.blue[800],
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
                                MaterialPageRoute(builder: (context) => VehicleEntry(vehicle: vehicleDetails[5])),
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
                    ],
                  ),
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
      padding: EdgeInsets.symmetric(horizontal: 16),
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

  Widget vehicleInput() {
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
                controller: plateNumController,
                decoration: const InputDecoration(labelText: 'Plate Number'),
              ),
              const SizedBox(height: 50),
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
      ),
    );
  }


}