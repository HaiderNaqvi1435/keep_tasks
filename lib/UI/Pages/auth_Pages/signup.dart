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
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController namecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passcont = TextEditingController();
  bool obscure = true;
  bool obscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: formkey,
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
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Please enter name";
                        } else
                          return null;
                      },
                      controller: namecont,
                      decoration: Utils.authField(label: "Name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Please enter email";
                        } else
                          return null;
                      },
                      controller: emailcont,
                      decoration: Utils.authField(label: "Email"),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Please enter password";
                        } else if (value.length < 6) {
                          return "Minimun 6 Characters";
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Please confirm password";
                        } else if (value != passcont.text) {
                          return "Password not Matched";
                        }
                        return null;
                      },
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
                        if (formkey.currentState!.validate()) {
                          await addUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 45),
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

  addUser() async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    UserData userData = UserData(
      email: emailcont.text.toLowerCase().trim(),
      name: namecont.text,
    );
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailcont.text.toLowerCase().trim(),
              password: passcont.text)
          .then((value) async {
        print("user create succssfully");
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(value.user!.uid)
            .set(userData.toMap());
      }).then((value) {
        FirebaseAuth.instance
            .signOut()
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                )));
      });

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      Navigator.of(context).pop();
      print("Something went wrong $e");
    }
  }
}
