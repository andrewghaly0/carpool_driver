import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String? driverName;
  String? carID;
  String? phoneNumber;

  // Add any additional fields as needed

  void setUserData(String driverName, String carID, String phoneNumber) {
    this.driverName = driverName;
    this.carID = carID;
    this.phoneNumber = phoneNumber;

    // Add any additional logic or updates as needed

    // Notify listeners that the data has changed
    notifyListeners();
  }
}
