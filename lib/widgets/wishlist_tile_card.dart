import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class WishlistTileCard extends StatelessWidget {
  final ProductModel product;

  WishlistTileCard({required this.product});

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.galleries![0].url.toString(),
              width: 60,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.toString(),
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  product.price.toString(),
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);
            },
            child: Image.asset(
              'assets/icon_favourite_blue.png',
              width: 34,
            ),
          ),
        ],
      ),
    );
  }
}
