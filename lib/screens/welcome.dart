import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 40),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Container(
                          padding: EdgeInsets.only(top: 60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: InkWell(
                              child: Image(
                                image: AssetImage('assets/images/Logo.png'),
                              ),
                              onTap: () => {
                                    Navigator.pushNamed(context, '/signin'),
                                  }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "THE TAXI DRIVER",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "WHENEVER WHEREVER",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
