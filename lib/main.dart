import 'package:flutter/material.dart';
import 'package:the_taxi_driver/screens/dashboard.dart';
import 'package:the_taxi_driver/screens/sign_in.dart';
import 'package:the_taxi_driver/screens/sign_up.dart';
import 'package:provider/provider.dart';

import 'DataHandler/appData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/signup': (BuildContext context) => RegisterPage(),
          '/signin': (BuildContext context) => SignInPage(),
          '/dashboard': (BuildContext context) => Dashboard(),
        },
        title: 'THE TAXI DRIVER',
        home: Dashboard(),
      ),
    );
  }
}
