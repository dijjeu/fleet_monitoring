import 'package:fleet_monitoring/login/login.dart';
import 'package:fleet_monitoring/repositories/app_state.dart';
import 'package:fleet_monitoring/repositories/service_entry.dart';
import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(),
        ),
        ChangeNotifierProvider<VehicleDetails>.value(
          value: VehicleDetails(
            carMake: '',
            color: '',
            yearModel: '',
            plateNum: '',
            regisNum: '',
            orNum: '',
            regisDate: '',
            regisExp: '',
            orDateIssued: '',
          ),
        ),
        ChangeNotifierProvider<ServiceEntry>(
          create: (_) => ServiceEntry(
              serviceType: 'Appointment',
              odometer: '',
              serviceDate: '',
              serviceTime: '',
              location: '',
              plateNumber: ''),
        ),
      ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fleet Monitoring App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Login(),
    );
  }
}