import 'package:flutter/material.dart';
import 'package:rayatro_cloth2/constans/colors.dart';
import 'package:rayatro_cloth2/login.dart';
import 'package:rayatro_cloth2/singup.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo_transparent.png',
              errorBuilder: (context, error, stackTrace) {
                return Text('Error loading image: $error');
              },
            ),
            
            Text(
              'Transformez votre style ',
              style: TextStyle(
                fontSize: 30,
                color: const Color.fromARGB(255, 255, 185, 185),
                
                fontFamily: 'az',
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              ' achetez et vendez vos vêtements en ligne avec facilité !',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 255, 185, 185),
                fontFamily: 'az',
                
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
             Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Color.fromARGB(209, 253, 252, 252),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                   Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );// Action for create an account button
                },
                child: Text('Créer un compte',
                 style: TextStyle(color: Colors.black, 
                 fontFamily: 'Eloquia_Display_ExtBd'),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );// Action for I already have an account button
                },
                child: Text(
                  "j'ai deja un compte",
                  style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontFamily: 'EloquiaText-ExtraLight',),

                ),
              ),
            ],
          ),
          ],
        ),
      ),
      backgroundColor:primary, // Replace with your desired background color
    );
  }
}