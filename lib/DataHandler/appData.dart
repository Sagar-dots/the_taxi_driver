import 'package:flutter/cupertino.dart';
import 'package:the_taxi_driver/Models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUplocation, dropOffLocation;

  void updatePickupLocationAddress(Address pickUpAddress) {
    pickUplocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
