import 'package:fleet_monitoring/repositories/service_entry.dart';
import 'package:fleet_monitoring/repositories/user_repository.dart';
import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppState extends ChangeNotifier {
  List<VehicleDetails> vehicleDetails = List.empty(growable: true);
  List<VehicleDetails> allVehicles = List.empty(growable: true);
  List<ServiceEntry> _serviceEntries = [];

  List<ServiceEntry> get serviceEntries => _serviceEntries;

  UserRepository? _userData;

  UserRepository? get userData => _userData;

  VehicleDetails? _vehicleDetail;

  VehicleDetails? get vehicleDetail => _vehicleDetail;

  void setUserData(UserRepository userData) {
    _userData = userData;
    notifyListeners();
  }

  void setVehicleDetail(VehicleDetails vehicleDetail) {
    _vehicleDetail = vehicleDetail;
    notifyListeners();
  }

  setServiceEntries(List<ServiceEntry> entries) {
    _serviceEntries = entries;
    notifyListeners();
  }

  bool isRegistrationExpired() {
    if (_vehicleDetail != null) {
      final currentDate = DateTime.now();
      final expiryDate =
          DateFormat('MM/dd/yyyy').parse(_vehicleDetail!.regisExp);
      return currentDate.isAfter(expiryDate);
    }
    return false;
  }

  void addVehicle(VehicleDetails newVehicle) {
    vehicleDetails.add(newVehicle);
    allVehicles.add(newVehicle);
    notifyListeners();
  }

  void deleteVehicle(int index) {
    if (index >= 0 && index < vehicleDetails.length) {
      vehicleDetails.removeAt(index);
      notifyListeners();
    }
  }
}
