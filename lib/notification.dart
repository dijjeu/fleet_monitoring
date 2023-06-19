import 'package:fleet_monitoring/repositories/app_state.dart';
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
    VehicleDetails? vehicleDetail = Provider.of<AppState>(context).vehicleDetail;

    String? registrationExpiryString = vehicleDetail?.regisExp;
    DateTime? registrationExpiryDate = registrationExpiryString != null
        ? DateFormat('MM/dd/yyyy').parse(registrationExpiryString)
        : null;


    String? licenseExpiryString = userData?.licenseExpiry;
    DateTime? licenseExpiryDate = licenseExpiryString != null
        ? DateFormat('MM/dd/yyyy').parse(licenseExpiryString)
        : null;

    List<ListTile> notificationListTiles = [];

    if (licenseExpiryDate != null) {
      DateTime today = DateTime.now();
      DateTime thirtyDaysFromNow = today.add(Duration(days: 30));
      bool isLicenseAlmost = licenseExpiryDate.isBefore(thirtyDaysFromNow);
      bool isLicenseExpiring = licenseExpiryDate.year == today.year &&
          licenseExpiryDate.month == today.month &&
          licenseExpiryDate.day == today.day;

      if (isLicenseExpiring) {
        notificationListTiles.add(
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
        notificationListTiles.add(
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

    // Add expired vehicles to the notificationListTiles
    List<VehicleDetails> expiredVehicles = Provider.of<AppState>(context).vehicleDetails;
    for (var vehicle in expiredVehicles) {
      notificationListTiles.add(
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
            'Your vehicle registration is expired. Please avoid using the vehicle and renew as soon as possible!',
          ),
        ),
      );
    }




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
                ...notificationListTiles,
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
}
