import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';

import '../HomePage.dart';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  sendNewEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      showBottomSheet(
        context: context,
        builder: (context) => SnackBar(
          content: Text("Email sent Successfullyy"),
        ),
      );

      // await user.sendEmailVerification();

      setState(() {
        resendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        resendEmail = true;
      });
    } catch (e) {
      showBottomSheet(
        context: context,
        builder: (context) => SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  isEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) timer?.cancel();
  }

  bool isVerified = false;
  bool resendEmail = false;

  Timer? timer;
  @override
  void initState() {
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendNewEmail();
      timer = Timer.periodic(Duration(seconds: 3), (_) => isEmailVerified());
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isVerified == true
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text(
              "Verify Email",
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Text(
                    "A verification email has been sent to your email",
                    style: Utils.normalText(
                        // color: MyThemes.MyTheme.colorScheme.primary
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                    onPressed:
                        //  () {
                        //   Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => Signin(),
                        //       ));
                        // },
                        resendEmail == true ? sendNewEmail : () {},
                    child: Text(
                      "Resent Email",
                    )),
              ],
            ),
          ),
        );
}
