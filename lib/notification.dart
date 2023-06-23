import 'dart:collection';
import 'package:fleet_monitoring/repositories/app_state.dart';
import 'package:fleet_monitoring/repositories/service_entry.dart';
import 'package:fleet_monitoring/repositories/user_repository.dart';
import 'package:fleet_monitoring/repositories/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository? userData = Provider.of<AppState>(context).userData;

    List<ServiceEntry>? serviceEntries =
        Provider.of<AppState>(context).serviceEntries;

    // Call setServiceEntries to populate the serviceEntries list
    Provider.of<AppState>(context, listen: false)
        .setServiceEntries(serviceEntries!);

    VehicleDetails? vehicleDetail =
        Provider.of<AppState>(context).vehicleDetail;

    String? registrationExpiryString = vehicleDetail?.regisExp;


    String? licenseExpiryString = userData?.licenseExpiry;
    DateTime? licenseExpiryDate = licenseExpiryString != null
        ? DateFormat('MM/dd/yyyy').parse(licenseExpiryString)
        : null;

    String? appointmentDateString =
        serviceEntries.isNotEmpty ? serviceEntries[0].serviceDate : null;
    DateTime? appointmentDate = appointmentDateString != null
        ? DateFormat('MM/dd/yyyy').parse(appointmentDateString)
        : null;

    Queue<ListTile> notificationListTiles = Queue<ListTile>();

    /// -- APPOINTMENT LIST -- ///
    apptList(context, notificationListTiles);

    /// -- DRIVER'S LICENSE LIST -- ///
    licenseList(licenseExpiryDate, notificationListTiles);

    /// -- REGISTRATION LIST -- ///
    regisList(context, notificationListTiles);

    return Scaffold(
      body: notificationListTiles.isNotEmpty
          ? ListView(
              padding: EdgeInsets.all(20),
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    'Notifications',
                    style: GoogleFonts.montserrat(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(height: 10),
                ...notificationListTiles.toList(),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notifications',
                      style: GoogleFonts.montserrat(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    Text('No notifications'),
                  ],
                ),
              ),
            ),
    );
  }

  void regisList(BuildContext context, Queue<ListTile> notificationListTiles) {
    List<VehicleDetails> expiredVehicles =
        Provider.of<AppState>(context).vehicleDetails;
    for (var vehicle in expiredVehicles) {
      DateTime today = DateTime.now();
      DateTime thirtyDaysFromNow = today.add(Duration(days: 30));

      // Parse registration expiry string into DateTime object
      DateTime? registrationExpiry = vehicle.regisExp != null
          ? DateFormat('MM/dd/yyyy').parse(vehicle.regisExp)
          : null;

      bool isRegistrationAlmost = registrationExpiry != null &&
          registrationExpiry.isBefore(thirtyDaysFromNow);
      bool isRegistrationExpiring = registrationExpiry != null &&
          registrationExpiry.year == today.year &&
          registrationExpiry.month == today.month &&
          registrationExpiry.day == today.day;

      if (isRegistrationExpiring) {
        notificationListTiles.addLast(
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red[400]),
            title: Text(
              'Vehicle Registration Expiry: ${vehicle.regisExp}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
            subtitle: Text(
              'Your vehicle registration is expired for ${vehicle.plateNum}. Please avoid using the vehicle and renew as soon as possible!',
            ),
          ),
        );
      } else if (isRegistrationAlmost) {
        notificationListTiles.addLast(
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text(
              'Vehicle Registration Expiry: ${vehicle.regisExp}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            subtitle: Text(
              'Your registration is about to expire for ${vehicle.plateNum}. Please renew as soon as possible!',
            ),
          ),
        );
      }
    }
  }

  void licenseList(
      DateTime? licenseExpiryDate, Queue<ListTile> notificationListTiles) {
    if (licenseExpiryDate != null) {
      DateTime today = DateTime.now();
      DateTime thirtyDaysFromNow = today.add(Duration(days: 30));
      bool isLicenseAlmost = licenseExpiryDate.isBefore(thirtyDaysFromNow);
      bool isLicenseExpiring = licenseExpiryDate.year == today.year &&
          licenseExpiryDate.month == today.month &&
          licenseExpiryDate.day == today.day;

      if (isLicenseExpiring) {
        notificationListTiles.addLast(
          ListTile(
            leading: Icon(Icons.warning, color: Colors.red[400]),
            title: Text(
              'License Expiry: ${licenseExpiryDate != null ? DateFormat('MM/dd/yyyy').format(licenseExpiryDate) : 'N/A'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
            subtitle: Text(
              'Your driver\'s license is expired. Please avoid driving and renew as soon as possible!',
            ),
          ),
        );
      } else if (isLicenseAlmost) {
        notificationListTiles.addLast(
          ListTile(
            leading: Icon(Icons.warning, color: Colors.orange),
            title: Text(
              'License Expiry: ${licenseExpiryDate != null ? DateFormat('MM/dd/yyyy').format(licenseExpiryDate) : 'N/A'}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            subtitle: Text(
              'Your driver\'s license is about to expire. Please renew as soon as possible!',
            ),
          ),
        );
      }
    }
  }

  void apptList(BuildContext context, Queue<ListTile> notificationListTiles) {
    List<ServiceEntry>? appointmentVehicles =
        Provider.of<AppState>(context).serviceEntries;

    if (appointmentVehicles != null && appointmentVehicles.isNotEmpty) {
      DateTime today = DateTime.now();
      DateTime thirtyDaysFromNow = today.add(Duration(days: 30));

      for (var appointment in appointmentVehicles) {
        DateTime? appointmentDate = appointment.serviceDate != null
            ? DateFormat('MM/dd/yyyy').parse(appointment.serviceDate)
            : null;

        bool isAppointmentAlmost = appointmentDate != null &&
            appointmentDate.isBefore(thirtyDaysFromNow);
        bool isAppointmentToday = appointmentDate != null &&
            appointmentDate.year == today.year &&
            appointmentDate.month == today.month &&
            appointmentDate.day == today.day;

        if (isAppointmentToday) {
          notificationListTiles.addLast(
            ListTile(
              leading:
              Icon(Icons.calendar_today_rounded, color: Colors.blue[800]),
              title: Text(
                'Appointment: ${appointment.serviceDate}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              subtitle: Text(
                'You have an appointment today for ${appointment.plateNumber} on ${appointment.serviceTime}!',
              ),
            ),
          );
        } else if (isAppointmentAlmost) {
          notificationListTiles.addLast(
            ListTile(
              leading:
              Icon(Icons.calendar_today_rounded, color: Colors.blue[800]),
              title: Text(
                'Appointment: ${DateFormat('MM/dd/yyyy').format(appointmentDate!)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              subtitle: Text(
                'You have an appointment on ${DateFormat('MM/dd/yyyy').format(appointmentDate!)} at ${appointment.serviceTime}',
              ),
            ),
          );
        }
      }
    } else {
      notificationListTiles.addLast(
        ListTile(
          title: Text('No appointments'),
        ),
      );
    }
  }
}
