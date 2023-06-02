import 'package:fleet_monitoring/notification.dart';
import 'package:fleet_monitoring/vehicle/vehicle.dart';
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
    super.dispose();
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
              searchBar(),
              /*vehicleDetails.isEmpty
                  ? Text(
                'No vehicles listed yet..',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ) :*/
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                    onPageChanged: (index) {
                      pageNum = index;
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
                  itemCount: 5,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) =>
                  Container(
                    margin: const EdgeInsets.all(2),
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: pageNum == index ? Colors.blue[800] : Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'CAR 9310', //plate number
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
                          'Mazda 2', //car make
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '2019', //year model
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
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.info_outline_rounded, color: Colors.black87),
                              SizedBox(width: 8), // Optional spacing between the icon and text
                              Text('Information'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.edit_note_outlined, color: Colors.black87),
                              SizedBox(width: 8), // Optional spacing between the icon and text
                              Text('Edit'),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Add a new vehicle'),
                          SizedBox(width: 50),
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
                        onPressed: () {},
                        child: Text('View all vehicles'),
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
}