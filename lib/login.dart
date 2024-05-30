import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rayatro_cloth2/components/custombuttonauth.dart';
import 'package:rayatro_cloth2/components/textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login To Continue Using The App",
                    style: TextStyle(color: Color.fromARGB(255, 46, 45, 45)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    key: UniqueKey(),
                    hinttext: "Enter Your Email",
                    mycontroller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    key: UniqueKey(),
                    hinttext: "Enter Your Password",
                    mycontroller: password,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonAuth(
              title: "Login",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    Navigator.of(context).pushReplacementNamed("home");
                  } on FirebaseAuthException catch (e) {
                    await showLoginErrorSnackbar(
                        context, getErrorMessage(e.code));
                  }
                } else {
                  print("Not valid");
                }
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "assets/images/google.png",
                    width: 20,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: const Center(
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: "Don't Have An Account? "),
                  TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user?.displayName);
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle the error accordingly
    }
  }

  Future<void> showLoginErrorSnackbar(BuildContext context, String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        duration: const Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          message: message,
          contentType: ContentType.failure,
          title: '',
        ),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            email.clear();
            password.clear();
          },
        ),
        )
    );
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "Invalid email. Please check and try again.";
      case "wrong-password":
        return "Incorrect password. Please try again.";
      default:
        return "An error occurred. Please try again later.";
    }
  }
}
