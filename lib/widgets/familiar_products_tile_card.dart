import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class FamiliarProductsTileCard extends StatelessWidget {
  final String imageUrl;

// ignore: use_key_in_widget_constructors
  const FamiliarProductsTileCard(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 12,
        bottom: 30,
        right: 16,
      ),
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}
