import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/signup.dart';
import 'package:provider/provider.dart';

import '../../../Core/Classes/Database/AuthProviders.dart';
import '../../../Core/Classes/Database/TasksProvider.dart';
import '../../../Core/Classes/Themes/MyTheme.dart';
import '../HomePage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style:
                    Utils.logintext(size: 40, bold: true, color: Colors.black),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('Please login to continue using this app'),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                decoration: Utils.authField(label: "Email"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: obscure,
                decoration: Utils.authField(
                    label: "Password",
                    icondata: obscure != true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onpress: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forget Password?',
                    style: Utils.metaText(
                        color: MyThemes.MyTheme.colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => HomePage(),
                  //     ));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'Login',
                  style: Utils.normalText(size: 20, bold: true),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text(
                      'Sign up',
                      style: Utils.metaText(
                        size: 16,
                        bold: true,
                        color: MyThemes.MyTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              // Text.rich(
              //   TextSpan(
              //     children: [
              //        TextSpan(text: 'Already have an account? '),
              //       TextSpan(
              //         text: 'Sign up',
              //         style: Utils.metaText(
              //           size: 16,
              //           bold: true,
              //           color: MyThemes.MyTheme.colorScheme.primary,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
