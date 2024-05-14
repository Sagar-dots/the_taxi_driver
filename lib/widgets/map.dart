import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:the_taxi_driver/DataHandler/appData.dart';
import 'package:the_taxi_driver/assistants/assistantMethods.dart';
import 'package:the_taxi_driver/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_taxi_driver/screens/searchScreen.dart';

class MapViews extends StatefulWidget {
  @override
  _MapViewsState createState() => _MapViewsState();
}

class _MapViewsState extends State<MapViews> {
  Completer<GoogleMapController> _controllerGoogleMaps = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polyline = {};
  Position currentposition;
  var geoLocator = Geolocator();
  double bottomPaddingofMap = 0;
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  void locateUserPoisition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentposition = position;

    LatLng lnglatposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: lnglatposition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String address =
        await AssistantMethoods.searchCoordinates(position, context);
    print("This is your address: " + address);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        leading: Container(),
        title: Text('Dashboard'),
      ),
      drawer: Container(
        color: Colors.white,
        width: 280.0,
        child: Drawer(
          elevation: 16.0,
          child: ListView(
            children: [
              Container(
                height: 170,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: kbackgroundColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          border: Border.all(
                            color: kbackgroundColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 16.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                0.7,
                                0.7,
                              ),
                            ),
                          ],
                        ),
                        child: Icon(
                          FontAwesomeIcons.user,
                          size: 40,
                          color: kbackgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Visit Profile",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1.0,
                color: Colors.black87,
                thickness: 1.0,
              ),
              SizedBox(
                height: 12.0,
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.history),
                title: Text(
                  "History",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.personBooth),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.infoCircle),
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Roboto',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            mapType: MapType.normal,
            polylines: _polyline,
            markers: markers,
            circles: circles,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            trafficEnabled: false,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMaps.complete(controller);
              newGoogleMapController = controller;
              setState(() {
                bottomPaddingofMap = 300.0;
              });
              locateUserPoisition();
            },
          ),
          //hamburger button for the drawer
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                scaffoldkey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: kbackgroundColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu, color: Colors.black),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: kbackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hello There',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: 2,
                            fontSize: 10),
                      ),
                    ),
                    Text(
                      'WHERE T0?',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: TextStyle(
                            color: Colors.black87,
                            letterSpacing: 2,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      focusColor: Colors.grey,
                      splashColor: Colors.grey,
                      onTap: () async {
                        var response = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                        if (response == "obtainDirection") {
                          print("I am in");
                          await getPlaceDirection();
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              FontAwesomeIcons.search,
                              color: Colors.black87,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Destination Search',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    letterSpacing: 2,
                                    fontSize: 15),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.home,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Provider.of<AppData>(context).pickUplocation !=
                                      null
                                  ? Provider.of<AppData>(context)
                                      .pickUplocation
                                      .placeName
                                  : "Add Home",
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    letterSpacing: 2,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Your Current Living address',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 2,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Divider(
                      height: 1.0,
                      color: Colors.black87,
                      thickness: 1.0,
                    ),
                    SizedBox(height: 18.0),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.briefcase,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Work Place',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                    color: Colors.black87,
                                    letterSpacing: 2,
                                    fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Add your office Address',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                textStyle: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 2,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var initialposi =
        Provider.of<AppData>(context, listen: false).pickUplocation;
    var finalposi =
        Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickupLatlng = LatLng(initialposi.latitude, initialposi.longitude);
    var dropOffLatlng = LatLng(finalposi.latitude, finalposi.longitude);
    var details = await AssistantMethoods.obtainDirectionsDetails(
        pickupLatlng, dropOffLatlng);
    // Navigator.pop(context);
    print("This is Encoded points:");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        polylineCoordinates.add(
          LatLng(pointLatLng.latitude, pointLatLng.longitude),
        );
      });
    }
    setState(() {
      Polyline polyline = Polyline(
        color: Colors.green,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polylineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      _polyline.add(polyline);
    });
    LatLngBounds latLngBounds;
    if (pickupLatlng.latitude > dropOffLatlng.latitude &&
        pickupLatlng.longitude > dropOffLatlng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatlng, northeast: pickupLatlng);
    } else if (pickupLatlng.longitude > dropOffLatlng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickupLatlng.latitude, dropOffLatlng.longitude),
          northeast: LatLng(dropOffLatlng.latitude, pickupLatlng.longitude));
    } else if (pickupLatlng.latitude > dropOffLatlng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatlng.latitude, dropOffLatlng.longitude),
          northeast: LatLng(pickupLatlng.latitude, pickupLatlng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickupLatlng, northeast: dropOffLatlng);
    }
    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    Marker pickUplocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow:
          InfoWindow(title: initialposi.placeName, snippet: "Your Location"),
      position: pickupLatlng,
      markerId: MarkerId("pick Up ID"),
    );
    Marker dropOfflocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
          title: finalposi.placeName, snippet: "Your Drop off Location"),
      position: pickupLatlng,
      markerId: MarkerId("Drop off ID"),
    );
    setState(() {
      markers.add(pickUplocMarker);

      markers.add(dropOfflocMarker);
    });
    Circle pickupCircle = Circle(
      fillColor: Colors.yellow,
      center: pickupLatlng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.yellowAccent,
      circleId: CircleId("pickUP"),
    );
  }
}
