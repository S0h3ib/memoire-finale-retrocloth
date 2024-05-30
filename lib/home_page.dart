import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rayatro_cloth2/ProductScreen.dart';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:rayatro_cloth2/constans/colors.dart';




import 'package:rayatro_cloth2/notification_page.dart';
import 'package:rayatro_cloth2/product_item_screen.dart';
import 'package:rayatro_cloth2/provider/FavoritesProvider.dart';
import 'package:rayatro_cloth2/splashscreen.dart';

import 'package:rayatro_cloth2/upload_tap.dart';




import 'profile_page.dart';

import 'search_Screen.dart';

class Home extends StatefulWidget {
const Home({Key? key}) : super(key: key);


@override
 MyHomePageState createState() => MyHomePageState();
}



class MyHomePage extends StatefulWidget {
 
 const MyHomePage({super.key});

 @override
 MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static List previousSearchs = [];
  int _currentIndex = 0;
  
   
  
 
  
    @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       


      appBar: AppBar(

        elevation: 0,
      leading: 
           IconButton(
            icon: const Icon(Icons.menu, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () {},
          ),
        title: const Text(
        'rétro cloth',
         style: TextStyle(
          fontFamily: 'Poppins-Black',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 254, 254),),
        ),
        actions: <Widget>[
           IconButton(
            icon: const Icon(Icons.notifications_none, color: Color.fromARGB(255, 252 ,246 ,245)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  NotificationPage()),
              );
            },
           ),
        ],
        backgroundColor: Color.fromARGB(255, 153 ,0 ,17),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
     child:  Padding( 
        padding: const EdgeInsets.only(left: 5.0, right: 0.0),
        child: Column(
        children: [ 
         
          SizedBox(height: 5),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20.0),
             child: SearchBar(),
          ),
          const SizedBox(height: 5),
          
          Container(
            height: 40,
            child: ListView(
             scrollDirection: Axis.horizontal,
             children: <Widget>[
             Padding(
               padding: EdgeInsets.only(right: 30.0), // Add space between containers
               child: AspectRatio(
                 aspectRatio: 2 / 1,
                 child: Container(
                   decoration: BoxDecoration(
                     color: Color.fromARGB(255, 153 ,0 ,17),
                     borderRadius: BorderRadius.circular(20),
                    ),
               child: Center(
                 child: Text(
                   'Tous',
                  style: TextStyle(
                   color: Color.fromARGB(255, 246, 246, 246),
                   fontSize: 15,
                 ),
                ),
               ),
              ),
             ),
            ),
            Padding(
             padding: EdgeInsets.only(right: 30.0), // Add space between containers
             child: AspectRatio(
               aspectRatio: 2 / 1,
               child: Container(
                 decoration: BoxDecoration(
                   color: Color.fromARGB(255, 153 ,0 ,17),
                   borderRadius: BorderRadius.circular(20),
                  ),
              child: Center(
              child: Text(
                'Homme',
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 246, 246),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
             padding: EdgeInsets.only(right: 20.0), // Add space between containers
             child: AspectRatio(
               aspectRatio: 2 / 1,
               child: Container(
                 decoration: BoxDecoration(
                   color: Color.fromARGB(255, 153 ,0 ,17),
                   borderRadius: BorderRadius.circular(20),
                  ),
              child: Center(
              child: Text(
                'femme',
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 246, 246),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
             padding: EdgeInsets.only(left: 5.0), // Add space between containers
             child: AspectRatio(
               aspectRatio: 2 / 1,
               child: Container(
                 decoration: BoxDecoration(
                  color: Color.fromARGB(255, 153 ,0 ,17),
                   borderRadius: BorderRadius.circular(20),
                  ),
              child: Center(
              child: Text(
                'Enfant',
                style: TextStyle(
                  color: Color.fromARGB(255, 246, 246, 246),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
     
    ],
  ),
),

          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            width: 400,
            child:ListView(
             scrollDirection: Axis.horizontal,
             children:<Widget> [
                  listdr('assets/images/ll2.jpg'),
                  listdr('assets/images/ll1.jpg'),
                  listdr('assets/images/ll.avif'),
              ]
           ),
          ),
          SizedBox(height: 15),
          Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductContainer(
                        imageUrl: 'https://contents.mediadecathlon.com/p2255446/k7268b2af3a9d20956effda4b959f8b16/maillot-de-football-manches-courtes-viralto-solo-mc-jungle-jaune-fluo-et-noir.jpg?format=auto&quality=40&f=452x452',
                        Prix: '60',
                        Taille: '36',
                       Titre: 't-shirt football',
                        likes: '16',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://plazavea.vteximg.com.br/arquivos/ids/26158862-1000-1000/20268940.jpg',
                        Prix: '70',
                        Taille: '38',
                       Titre: 'Nike',
                        likes: '24',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://www.beige-habilleur.com/5833-large_default/camber-usa-sweatshirt-capuche-gris-chine.jpg',
                        Prix: '80',
                        Taille: '40',
                       Titre: 'Adidas',
                        likes: '30',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductContainer(
                        imageUrl: 'https://cdn.webshopapp.com/shops/297045/files/425082473/600x600x2/tee-jays-bestseller-dames-t-shirt-60o-wasbaar-zwar.jpg',
                        Prix: '90',
                        Taille: '42',
                       Titre: 't-shirt Puma',
                        likes: '12',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://www.zeeman.com/media/catalog/product/2/0/2003820322015_Front.jpg?quality=90&fit=bounds&height=700&width=700&canvas=700:700',
                        Prix: '100',
                        Taille: '44',
                       Titre: 'Reebok',
                        likes: '20',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://cdn.sarenza.cloud/_img/productsv4/0000368225/0000368225_651546_09_504x690.jpg?202309121645&v=20240516141925',
                        Prix: '110',
                        Taille: '46',
                       Titre: 'choussure noire',
                        likes: '18',
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProductContainer(
                        imageUrl: 'https://alchimistes.fr/14653-large_default/made-in-france-t-shirt-enfant.jpg',
                        Prix: '90',
                        Taille: '42',
                       Titre: 'Puma',
                        likes: '12',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://www.macadambasket.com/40160-large_default/pantalon-enfant-fleece-relaxed.jpg',
                        Prix: '100',
                        Taille: '44',
                       Titre: 'robe zara',
                        likes: '20',
                      ),
                      SizedBox(width: 10),
                      ProductContainer(
                        imageUrl: 'https://www.chaussmomes.com/media/catalog/product/cache/2/image/660x600/85e4522595efc69f496374d01ef2bf13/8/2/82563_vignettes_1.jpg',
                         Prix: '110',
                        Taille: '46',
                       Titre: 'New Balance',
                        likes: '18',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0), // Add horizontal padding between items
            child: ProductContainer(
              imageUrl: product['imageUrl'],
              Prix: product['Prix'].toString(),
              Taille: product['Taille'],
              Titre: product['Titre'],
              likes: '10',
            ),
          );
        }).toList(),
      ),
    );
  },
),
              ],
            ),
          ),
        )
          
           
                
                 
        ]
        ),
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
  Widget listdr(image){
    return AspectRatio(aspectRatio: 8/4 ,
    child: GestureDetector(
      onTap:()  {},
      child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
            ),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Color.fromARGB(0, 255, 255, 255).withOpacity(.8),
                    Color.fromARGB(95, 241, 241, 241).withOpacity(.1),
                  ]
                  )),
              child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                  )),
            ),
          ),
        ));
  }

}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  } 
}


class SearchBar extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchBar({super.key});
  @override
 Widget build(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 210, 4, 45), // Adjust border color
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0), // Adjust border radius
      ),
      child: Row( // Arrange icon and text field horizontally
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton( // Use IconButton for clickable icon
              icon: const Icon(Icons.search),
              color: const Color.fromARGB(255, 210, 4, 45), 
              onPressed: () { 
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const SearchScreen()),
                  );
                 }, // Adjust icon color 
            ),
          ),
          Expanded( // Make text field take up remaining space
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                border: InputBorder.none, // Hide default border
              ),
            ),
          ),
        ],
      ),
    );
}



} 
 

class ProductContainer extends StatefulWidget {
  final String imageUrl;
  final String Prix;
  final String Taille;
  final String Titre;
  final String likes;

  ProductContainer({
    required this.imageUrl,
    required this.Prix,
    required this.Taille,
    required this.Titre,
    required this.likes,
  });

  @override
  _ProductContainerState createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductItemScreen(
              imageUrl: widget.imageUrl,
              Prix: widget.Prix,
              Taille: widget.Taille,
              Titre: widget.Titre,
              likes: widget.likes,
            ),
          ),
        );
      },
      child: Container(
        height: 250,
        width: 195,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 246, 246, 246),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color.fromARGB(107, 197, 0, 0), width: 2, style: BorderStyle.solid),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.network(
                widget.imageUrl,
                height: 133,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'DA${widget.Prix}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Taille: ${widget.Taille}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Text(
                widget.Titre,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
  setState(() {
    isLiked = !isLiked;
  });

  final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
  if (isLiked) {
    favoritesProvider.addFavorite({
      'imageUrl': widget.imageUrl,
      'Prix': widget.Prix,
      'Taille': widget.Taille,
      'Titre': widget.Titre,
      'likes': widget.likes,
    });
  } else {
    favoritesProvider.removeFavorite(widget.imageUrl); // Assuming imageUrl is unique for each product
  }
},

                    child: Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.grey, size: 30),
                  ),
                  SizedBox(width: 4),
                  Text(widget.likes, style: TextStyle(fontSize: 12)),
                  Spacer(),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


