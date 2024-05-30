import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rayatro_cloth2/constans/colors.dart';

class MakeOfferPage extends StatefulWidget {
  final String imageUrl;
  final String Prix;
  final String Taille;
  final String Titre;

  const MakeOfferPage({
    Key? key,
    required this.imageUrl,
    required this.Prix,
    required this.Taille,
    required this.Titre,
  }) : super(key: key);

  @override
  _MakeOfferPageState createState() => _MakeOfferPageState();
}

class _MakeOfferPageState extends State<MakeOfferPage> {
  final TextEditingController _offerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faire une Offre'),
        backgroundColor: primary,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.imageUrl),
              SizedBox(height: 16),
              Text(
                widget.Titre,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Taille: ${widget.Taille}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Current Prix: ${widget.Prix} DA',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _offerController,
                decoration: InputDecoration(
                  labelText: 'ex: 1000 DA',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primary, // Change this to your desired color
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primary, // Change this to your desired color
                      width: 2.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    _offerController.value = TextEditingValue(
                      text: '${value} DA',
                      selection: TextSelection.collapsed(offset: value.length + 3),
                    );
                  });
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement make an offer functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: primary,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: Text('Submit Offer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
