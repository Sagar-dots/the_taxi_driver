import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:the_taxi_driver/DataHandler/appData.dart';
import 'package:the_taxi_driver/Models/address.dart';
import 'package:the_taxi_driver/Models/placeNamePredictions.dart';

import 'package:the_taxi_driver/assistants/requestAssistant.dart';
import 'package:the_taxi_driver/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_taxi_driver/widgets/configmaps.dart';
import 'package:the_taxi_driver/widgets/widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextController = TextEditingController();
  TextEditingController dropOffTextController = TextEditingController();
  List<PlacePredictions> placePredictionsList = [];
  @override
  Widget build(BuildContext context) {
    String placeAddress =
        Provider.of<AppData>(context).pickUplocation.placeName ?? "";
    pickUpTextController.text = placeAddress;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 260.0,
              decoration: BoxDecoration(
                color: kbackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 25.0, top: 20.0, right: 25.0, bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.0),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(FontAwesomeIcons.angleDoubleLeft)),
                        Center(
                          child: Text(
                            "Set Drop off location",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.taxi),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: MyTextField(
                                hintText: 'PickUp location ',
                                inputType: TextInputType.text,
                                controller: pickUpTextController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.mapMarker),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: MyTextField(
                                hintText: 'Drop off location ',
                                onChanged: (val) => findPlace(val),
                                inputType: TextInputType.text,
                                controller: dropOffTextController,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.0,
            ),
            (placePredictionsList.length > 0)
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: PredicitonTiles(
                            placePredictions: placePredictionsList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        thickness: 2.0,
                        color: Colors.black87,
                      ),
                      itemCount: placePredictionsList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890component=country:np";
      var response = await RequestAssistant.getRequest(autoCompleteUrl);
      if (response == "failed") {
        return;
      }
      if (response["status"] == "OK") {
        var predictions = response["predictions"];
        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          placePredictionsList = placesList;
        });
      }
    }
  }
}

class PredicitonTiles extends StatelessWidget {
  final PlacePredictions placePredictions;

  PredicitonTiles({Key key, this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        print(placePredictions);
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      placePredictions.main_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      placePredictions.secondary_text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 8.0,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Getting drop-off location...",
        ),
      ),
    );

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";
    var res = await RequestAssistant.getRequest(placeDetailsUrl);
    print(placeDetailsUrl);
    print(res);
    Navigator.pop(context);

    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];

      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);
      print("Drop off location Selected ::");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
