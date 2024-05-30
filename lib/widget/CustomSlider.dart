import 'package:rayatro_cloth2/constans/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double slider = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Taille",
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Eloquia_Display_ExtendBd',color: mainText,),
            ),
            Text(
              "",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Petit",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: primary),
                  ),
                  Text(
                    "Moyen",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: primary),
                  ),
                  Text(
                    "Grand",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: primary),
                  ),
                   
                  
                ],
              ),
            ),
            Slider(
                divisions: 2,
                activeColor: primary,
                thumbColor: primary,
                max: 60,
                min: 10,
                value: slider,
                onChanged: (value) {
                  setState(() {
                    slider = value;
                  });
                })
          ],
        )
      ],
    );
  }
}