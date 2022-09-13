import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Database/AuthProviders.dart';
import 'package:keep_tasks/Core/Classes/Models/UserModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/Login.dart';
import 'package:provider/provider.dart';

import '../../../Core/Classes/Themes/MyTheme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController namecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  bool obscure = true;
  bool obscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: Utils.logintext(
                          size: 40, bold: true, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Please fill the details and Create Account'),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: namecont,
                      decoration: Utils.authField(label: "Name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailcont,
                      decoration: Utils.authField(label: "Email"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passcont,
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
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: obscure2,
                      decoration: Utils.authField(
                          label: "Confirm Password",
                          icondata: obscure2 != true
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onpress: () {
                            setState(() {
                              obscure2 = !obscure2;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print(emailcont.text);
                        print(namecont.text);
                        UserData userData = UserData(
                          email: emailcont.text,
                          name: namecont.text,
                        );

                        await auth.addUser(
                            userData: userData,
                            password: passcont.text,
                            email: emailcont.text);
                        Future.delayed(Duration.zero).then((value) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(250, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Sign up',
                        style: Utils.normalText(size: 20, bold: true),
                      ),
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
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text(
                            'Login',
                            style: Utils.metaText(
                              size: 16,
                              bold: true,
                              color: MyThemes.MyTheme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
