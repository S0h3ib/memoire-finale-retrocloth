import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rayatro_cloth2/SuccessPage.dart';
import 'package:rayatro_cloth2/address_page.dart';
import 'package:rayatro_cloth2/constans/colors.dart';

class BuyPage extends StatefulWidget {
  final String imageUrl;
  final String Prix;
  final String Titre;

  const BuyPage({
    Key? key,
    required this.imageUrl,
    required this.Prix,
    required this.Titre,
    
  }) : super(key: key);

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  bool _isDeliveryAtHome = false;
  String? _selectedPaymentMode;
  String? _deliveryAddress;
   String? _phoneNumber;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   Future<void> _handlePurchase() async {
    if (_deliveryAddress!= null && _selectedPaymentMode!= null) {
      final purchaseData = {
        'imageUrl': widget.imageUrl,
        'title': widget.Titre,
        'price': widget.Prix,
        'deliveryAddress': _deliveryAddress,
        'paymentMode': _selectedPaymentMode,
        'phoneNumber': _phoneNumber, // assuming you have a _phoneNumber variable
      };

       await _firestore.collection('purchases').add(purchaseData);

    // Show notification
    await FlutterLocalNotificationsPlugin().show(
      0,
      'Achat réussi',
      'Votre achat a été effectué avec succès!',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
           channelDescription: 'Channel Description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );

      // Navigate to success page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage()),
      );
    } else {
      // Show error message if required fields are not filled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiement'),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.imageUrl),
              SizedBox(height: 16),
              Text(
                'Commande',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(widget.Titre, style: TextStyle(fontSize: 16)),
              Divider(),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${widget.Prix} DA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 16),
              Text('Adresse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(
                        onAddressSaved: (address) {
                          setState(() {
                            _deliveryAddress = address;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Text(_deliveryAddress ?? 'Ajouter l\'adresse de livraison'),
              ),
              SizedBox(height: 16),
              Text('Options de livraison', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Envoi avec une agence de livraison'),
                subtitle: Text('à partir de 75 DA'),
                trailing: Radio<bool>(
                  value: false,
                  groupValue: _isDeliveryAtHome,
                  onChanged: (value) {
                    setState(() {
                      _isDeliveryAtHome = value!;
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Envoi à domicile'),
                subtitle: Text('90 DA'),
                trailing: Radio<bool>(
                  value: true,
                  groupValue: _isDeliveryAtHome,
                  onChanged: (value) {
                    setState(() {
                      _isDeliveryAtHome = value!;
                    });
                  },
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Text('Paiement', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Column(
                children: [
                  RadioListTile(
                    title: Text('CCP'),
                    value: 'CCP',
                    groupValue: _selectedPaymentMode,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMode = value as String?;
                      });
                    },
                  ),
                  if (_selectedPaymentMode == 'CCP')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Numéro CCP',
                        ),
                      ),
                    ),
                  RadioListTile(
                    title: Text('main à main'),
                    value: 'main à main',
                    groupValue: _selectedPaymentMode,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMode = value as String?;
                      });
                    },
                  ),
                  if (_selectedPaymentMode == 'main à main')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Détails main à main',
                        ),
                      ),
                    ),
                  // Ajoutez d'autres options de paiement ici
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed:  _handlePurchase,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('Payer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}