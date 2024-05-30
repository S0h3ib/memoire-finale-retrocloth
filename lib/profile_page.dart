import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:rayatro_cloth2/constans/colors.dart';
import 'package:provider/provider.dart';
import 'package:rayatro_cloth2/editprofile.dart';
import 'package:rayatro_cloth2/home_page.dart';
import 'package:rayatro_cloth2/product_item_screen.dart';
import 'package:rayatro_cloth2/provider/FavoritesProvider.dart';
import 'package:rayatro_cloth2/models/chat_user.dart';
import 'package:rayatro_cloth2/search_Screen.dart';
import 'package:rayatro_cloth2/upload_tap.dart';
import 'package:rayatro_cloth2/widget/custom_binary_option.dart';
import 'package:rayatro_cloth2/widget/custom_button.dart';

class Profile extends StatefulWidget {
  

  Profile({
    Key? key,
   
  }) : super(key: key);
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {


   File? _image;
  final _auth = FirebaseAuth.instance;
  late User user;



  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!;
  }
  
   bool showFavorites = false;
   List<DocumentSnapshot> userProducts = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }
  

  Future<String?> fetchUsername(String userId) async {
    try {
      final doc = await firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc.data()?['username'] as String?;
      } else {
        print('No such document!');
        return null;
      }
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }
  Future<void> uploadProduct(String imageUrl, String Prix, String Taille, String Titre) async {
  // Add the uploaded product to the list of user's articles
  // You can use Firestore or any other database to store the user's articles
  // For simplicity, let's assume you're using Firestore
  await firestore.collection('products').add({
    'imageUrl': imageUrl,
    'Prix': Prix,
    'Taille': Taille,
    'Titre': Titre,
  });
  

  // Update the state of the showFavorites variable
  setState(() {
    showFavorites = false;
  });
}
Future<void> _pickImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
    await _uploadProfilePicture( _image!);
    // Update 'newUsername' and 'newImageUrl' with the actual username and image URL.
  }
}
  Future<void> _uploadProfilePicture(File image) async {
    try {
      // Upload the file to Firebase Storage
      final storageRef = storage.ref().child('profile_pictures/${user.uid}.jpg');
      await storageRef.putFile(image);

      // Get the download URL
      final downloadURL = await storageRef.getDownloadURL();

      // Update the user's profile picture URL in Firestore
      await firestore.collection('users').doc(user.uid).update({'photoURL': downloadURL});

      // Update the user's profile picture URL in Firebase Authentication
      await user.updateProfile(photoURL: downloadURL);
      await user.reload();
      user = _auth.currentUser!;

      // Update the UI
      setState(() {});
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No user signed in.',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: mainText,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: mainText),
            onPressed: () => signOut(context),
          ),
        ],
        leading: 
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: mainText,
                  ),
                ),
              )
            
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromARGB(255, 177, 175, 175),
                          backgroundImage: currentUser.photoURL != null
                              ? NetworkImage(currentUser.photoURL!)
                              : null,
                          child: currentUser.photoURL == null
                              ? const Icon(Icons.person, size: 50, color: Color.fromARGB(255, 0, 0, 0))
                              : null,
                        ),
                        
                          InkWell(
                            onTap: _pickImage,
                          
                            
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: primary,
                              child: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    FutureBuilder<String?>(
                      future: fetchUsername(currentUser.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error loading username: ${snapshot.error}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Eloquia_Display_ExtBd',
                              color: mainText,
                            ),
                          );
                        } else {
                          final username = snapshot.data;
                          if (username == null) {
                            return Text(
                              'No username found',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Eloquia_Display_ExtBd',
                                color: mainText,
                              ),
                            );
                          } else {
                            return Text(
                              username,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Eloquia_Display_ExtBd',
                                color: mainText,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        currentUser.email!,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: SecondaryText),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Eloquia_Display_ExtBd',
                                color: mainText,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "articles",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: SecondaryText),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "789",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Eloquia_Display_ExtBd',
                                color: mainText,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "followers",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: SecondaryText),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "1.200",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Eloquia_Display_ExtBd',
                                color: mainText,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "suivi(e)s",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: SecondaryText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomBinaryOption(
                    textLeft: "Mes articles",
                    textRight: "Articles favoris",
                     onOptionChanged: (isFavorites) {
                setState(() {
                  showFavorites = isFavorites; // Update the state based on the selected option
                });
              },
                  ),
                   Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                final articlesToShow = showFavorites
                    ? favoritesProvider.favorites // Show favorite articles
                    : []; // Show user's articles (you need to implement this logic)

                return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1 / 1.3,
      children: List.generate(
        articlesToShow.length,
        (index) {
          final product = articlesToShow[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductItemScreen(
                    imageUrl: product['imageUrl']!,
                    Prix: product['Prix']!,
                    Taille: product['Taille']!,
                    Titre: product['Titre']!,
                    likes: product['likes']!,
                  ),
                ),
              );
            },
            child: ProductContainerForProfile(
              imageUrl: product['imageUrl']!,
              Prix: product['Prix']!,
              Taille: product['Taille']!,
              Titre: product['Titre']!,
            ),
          );
        },
      ),
    );
              },
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
bottomNavigationBar: BottomNavigationBar(
      backgroundColor: primary,
        onTap: (index) {
          Widget page=Container();
          switch (index) {
            case 0:
              page = MyHomePage();
              break;
            case 1:
              page = SearchScreen();
              break;
            case 2:
              page = UploadTap();
              break;
            case 3:
              page = Profile();
              break;
          }

          Navigator.push(context, MaterialPageRoute(builder: (context) => page));

        },
         type: BottomNavigationBarType.fixed,
  selectedItemColor: form, // Selected label color
  unselectedItemColor: form, // Unselected label color
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: form,),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
class ProductContainerForProfile extends StatelessWidget {
  final String imageUrl;
  final String Prix;
  final String Taille;
  final String Titre;

  ProductContainerForProfile({
    required this.imageUrl,
    required this.Prix,
    required this.Taille,
    required this.Titre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'DA$Prix',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Taille: $Taille',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            Titre,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

