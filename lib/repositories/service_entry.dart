import 'package:flutter/cupertino.dart';

class ServiceEntry with ChangeNotifier{
  final String serviceType;
  final String odometer;
  final String serviceDate;
  final String serviceTime;
  final String location;
  final String plateNumber;

  ServiceEntry({
    required this.serviceType,
    required this.odometer,
    required this.serviceDate,
    required this.serviceTime,
    required this.location,
    required this.plateNumber,
  });
}
