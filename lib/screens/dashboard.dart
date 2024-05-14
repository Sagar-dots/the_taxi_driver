import 'package:flutter/material.dart';
import 'package:the_taxi_driver/widgets/map.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1D313),
      body: MapViews(),
    );
  }
}
