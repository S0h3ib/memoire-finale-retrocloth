
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:rayatro_cloth2/home_page.dart';





class myproduct extends StatefulWidget {
  const myproduct({Key? key}) : super(key: key);

  @override
  myproductState createState() => myproductState();
}

class myproductState extends State<myproduct> {
  static List previousSearches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    );
  }

  Widget _buildHorizontalListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return ProductContainer(
                imageUrl: product['imageUrl'],
                Prix: product['price'].toString(),
                Taille: product['size'],
                Titre: product['title'],
                likes: product['likes'].toString(),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildProductListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return Column(
          children: products.map((product) {
            return ProductContainer(
              imageUrl: product['imageUrl'],
              Prix: product['price'].toString(),
              Taille: product['size'],
              Titre: product['title'],
              likes: product['likes'].toString(),
            );
          }).toList(),
        );
      },
    );
  }
}
  

