 import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ; 
  final TextEditingController mycontroller ; 
  final bool isPassword;
  final Key key; 
  final String? Function(String?)? validator;// Ajoutez le paramètre key

  const CustomTextForm({
    required this.key, 
    required this.hinttext, 
    required this.mycontroller, 
    this.isPassword = false, 
    required this.validator
  }) : super(key: key); // Utilisez le paramètre key dans l'appel au constructeur super

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      controller: mycontroller ,
      obscureText: isPassword,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 184, 184, 184))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
