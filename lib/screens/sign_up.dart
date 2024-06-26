import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_taxi_driver/screens/sign_in.dart';
import '../widgets/widget.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: AssetImage('assets/icon/backarrow.png'),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: kBackgroundColor,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: kHeadline,
                            ),
                            Text(
                              "Create new account to get started.",
                              style: kBodyText2,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            MyTextField(
                              hintText: 'Name',
                              inputType: TextInputType.name,
                              controller: null,
                            ),
                            MyTextField(
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                              controller: null,
                            ),
                            MyTextField(
                              hintText: 'Phone',
                              inputType: TextInputType.phone,
                              controller: null,
                            ),
                            MyPasswordField(
                              isPasswordVisible: passwordVisibility,
                              controller: null,
                              onTap: () {
                                setState(() {
                                  passwordVisibility = !passwordVisibility;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: kBodyText,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: kBodyText.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyTextButton(
                        buttonName: 'Register',
                        onTap: () {},
                        bgColor: Colors.black87,
                        textColor: kbackgroundColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
