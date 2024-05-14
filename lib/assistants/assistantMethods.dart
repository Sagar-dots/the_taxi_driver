import 'package:geolocator/geolocator.dart';
import 'package:the_taxi_driver/DataHandler/appData.dart';
import 'package:the_taxi_driver/Models/DirectonDetails.dart';
import 'package:the_taxi_driver/Models/address.dart';
import 'package:the_taxi_driver/assistants/requestAssistant.dart';
import 'package:the_taxi_driver/widgets/configmaps.dart';
import 'package:provider/provider.dart';
import 'package:latlng/latlng.dart';

class AssistantMethoods {
  static Future<String> searchCoordinates(Position position, context) async {
    String placeAddress = "";
    // String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(url);
    if (response != "Error!!!!Failed,") {
      // st1 = response["results"][0]["address_components"][4]["long_name"];
      // st2 = response["results"][0]["address_components"][7]["long_name"];
      // st3 = response["results"][0]["address_components"][6]["long_name"];
      // st4 = response["results"][0]["address_components"][9]["long_name"];
      // placeAddress = st1 + "," + st2 + "," + st3 + "," + st4;
      placeAddress = response["results"][0]["formatted_address"];
      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
      print(userPickUpAddress.longitude);
      Provider.of<AppData>(context, listen: false)
          .updatePickupLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainDirectionsDetails(
      initialLocation, finalLocation) async {
    // LatLng initialLocation;
    // LatLng finalLocation;

    String directionApiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialLocation.latitude},${initialLocation.longitude}&destination=${finalLocation.latitude},${finalLocation.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(directionApiUrl);
    print(response);
    if (response == "failed") {
      return null;
    }
    DirectionDetails detailsDirection = DirectionDetails();
    detailsDirection.encodedPoints =
        response["routes"][0]["overview_polyline"]["points"].toString();
    detailsDirection.distanceText =
        response["routes"][0]["legs"][0]["distance"]["text"].toString();
    detailsDirection.distanceValue =
        response["routes"][0]["legs"][0]["distance"]["value"].toString();
    detailsDirection.durationText =
        response["routes"][0]["legs"][0]["duration"]["text"].toString();
    detailsDirection.durationValue =
        response["routes"][0]["legs"][0]["duration"]["value"].toString();
    return detailsDirection;
  }
}
