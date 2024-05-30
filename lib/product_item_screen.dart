import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayatro_cloth2/buy_page.dart';
import 'package:rayatro_cloth2/constans/colors.dart';
import 'package:rayatro_cloth2/make_offer_page.dart';

import 'profile_page.dart';

class ProductItemScreen extends StatelessWidget {
  final String imageUrl;
  final String Prix;
  final String Taille;
  final String Titre;
  final String likes;

  const ProductItemScreen({
    Key? key,
    required this.imageUrl,
    required this.Prix,
    required this.Taille,
    required this.Titre,
    required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            buttonArrow(context),
            scroll(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                     SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MakeOfferPage(
                                imageUrl: imageUrl,
                                Prix: Prix,
                                Taille: Taille,
                                Titre: Titre,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:  primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('faire une offre',
                        style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'EloquiaText-ExtraLight',
                    color: Colors.white,
                  ),
                        ),
                      ),
                    ),
                   
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuyPage(
                                imageUrl: imageUrl,
                                Prix: Prix,
                                Titre: Titre,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:  primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('acheter',
                        style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'EloquiaText-ExtraLight',
                    color: Colors.white,
                  ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 40,
                color:  primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
                Text(
                  Titre,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Eloquia_Display_ExtBd',
                    color: mainText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Taille: $Taille',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/profilpic.jpg"),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Elena Shelby",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Eloquia_Display_ExtBd',
                        color: mainText,
                      ),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: primary,
                      child: Icon(
                        Icons.favorite_border,
                        color: Color.fromARGB(255, 246, 244, 244),
                        size: 24,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(likes, style: TextStyle(fontSize: 16)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 4,
                  ),
                ),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Eloquia_Display_ExtBd',
                    color: mainText,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: SecondaryText),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 4,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    height: 4,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
