import 'package:flutter/material.dart';

class Secrets {
  // Add your Google Maps API Key here
  static const API_KEY = 'AIzaSyDVXhvlQH7Wo1RHCqCKrwIfkdlzOqLBvt0';
}

// Colors
const kBackgroundColor = Color(0xffF4D140);
const kTextFieldFill = Color(0xff1E1C24);
// TextStyles
const kHeadline = TextStyle(
  color: Colors.black87,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

const Color kbackgroundColor = Color(0xffF1D313);
const kBodyText = TextStyle(
  color: Colors.black87,
  fontSize: 15,
);

const kButtonText = TextStyle(
  color: Colors.white70,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kBodyText2 =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87);
ShapeBorder kBackButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
  ),
);
