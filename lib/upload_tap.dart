import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayatro_cloth2/constans/colors.dart';
import 'package:rayatro_cloth2/home_page.dart';
import 'package:rayatro_cloth2/widget/custom_button.dart';
import 'package:rayatro_cloth2/widget/custom_text_fild_in_upload.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadTap extends StatefulWidget {
  const UploadTap({Key? key}) : super(key: key);

  @override
  _UploadTapState createState() => _UploadTapState();
}

class _UploadTapState extends State<UploadTap> {
  final _formKey = GlobalKey<FormState>();
  final _titreController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prixController = TextEditingController();
  String? _selectedSize;
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _uploadProduct() async {
    if (_formKey.currentState!.validate() && _image != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user signed in');
      return;
    }
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('product_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await imagesRef.putFile(File(_image!.path));
      final imageUrl = await imagesRef.getDownloadURL();
      final userId = currentUser.uid;
      final userPhotoURL = currentUser.photoURL;
      // Save product details to Firestore
       
      await FirebaseFirestore.instance.collection('products').add({
        'Titre': _titreController.text,
        'description': _descriptionController.text,
        'Prix': int.parse(_prixController.text),
        'Taille': _selectedSize,
        'imageUrl': imageUrl,
        'userId': userId, 
        'userPhotoURL': userPhotoURL,// Replace with actual user ID from Firebase Auth
      });

      // Navigate to home page or show success message
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: form,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addCoverPhoto(),
                      const SizedBox(height: 20),
                      Text(
                        "Titre",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Eloquia_Display_extralight',
                          color: mainText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextFildInUpload(
                        hint: "ex: Nike air force blanche",
                        radius: 30,
                        keyboardType: TextInputType.text,
                        colors: primary,
                        controller: _titreController,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Déscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Eloquia_Display_ExtendBd',
                          color: mainText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextFildInUpload(
                        hint: "ex: porté quelques fois, taille moyenne",
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        colors: primary,
                        controller: _descriptionController,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Prix (DA)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Eloquia_Display_ExtendBd',
                          color: mainText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CustomTextFildInUpload(
                        hint: "ex: 2000",
                        radius: 30,
                        keyboardType: TextInputType.number,
                        colors: primary,
                        controller: _prixController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un prix';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Veuillez entrer un nombre valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Taille",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Eloquia_Display_ExtendBd',
                          color: mainText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: form,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: Text("Sélectionner la taille"),
                        items: ["XS", "S", "M", "L", "XL", "XXL"]
                            .map((Taille) => DropdownMenuItem<String>(
                                  value: Taille,
                                  child: Text(Taille),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSize = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Veuillez sélectionner une taille';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: _uploadProduct,
                        text: "Next",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addCoverPhoto() {
    return InkWell(
      onTap: _pickImage,
      child: DottedBorder(
        dashPattern: [10, 5],
        color: primary,
        strokeWidth: 3,
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.photo,
                  size: 65,
                  color: Colors.grey,
                ),
                Text(
                  _image == null ? "+ Ajouter photos" : "Photo ajoutée",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Up to 12mp"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
