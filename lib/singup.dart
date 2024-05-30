import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rayatro_cloth2/components/custombuttonauth.dart';
import 'package:rayatro_cloth2/components/textformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  const Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "SignUp To Continue Using The App",
                    style: TextStyle(color: Color.fromARGB(255, 46, 45, 45)),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Username",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    key: UniqueKey(),
                    hinttext: "Enter Your Username",
                    mycontroller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Eloquia_Display_ExtBd',
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextForm(
                    key: UniqueKey(),
                    hinttext: "Enter Your Email",
                    mycontroller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                    mycontroller: passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Can't be empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    final user = credential.user;
                    if (user != null) {
                      print('User UID: ${user.uid}');
                      print('Document path: users/${user.uid}');

                      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
                        "username": usernameController.text,
                        "email": emailController.text,
                        
                      });
                       

                      Navigator.of(context).pushReplacementNamed("home");
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('The password provided is too weak.')),
                      );
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('The account already exists for that email.')),
                      );
                    }
                  } on FirebaseException catch (e) {
                    print('Firestore error: ${e.message}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred while accessing Firestore: ${e.message}')),
                    );
                  } catch (e, stackTrace) {
                    print('Error during sign-up: $e');
                    print(stackTrace);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An error occurred. Please try again later.')),
                    );
                  }
                } else {
                  print("Not valid");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("login");
              },
              child: const Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Have An Account? ",
                      ),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
