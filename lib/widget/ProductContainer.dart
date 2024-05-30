/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayatro_cloth2/product_item_screen.dart';
import 'package:rayatro_cloth2/provider/FavoritesProvider.dart';



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Product Container Example'),
        ),
        body:  
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
                       Titre: 'Converse',
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
                       Titre: 'Puma',
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
                       Titre: 'New Balance',
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
                       Titre: 'Reebok',
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProductContainer(
                        imageUrl: 'https://alchimistes.fr/14653-large_default/made-in-france-t-shirt-enfant.jpg',
                        Prix: '90',
                        Taille: '42',
                       Titre: 'Puma',
                        likes: '12',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
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
               userId: widget.userId,
                        userPhotoURL: ,
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
}*/
