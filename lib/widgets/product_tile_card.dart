import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ProductTileCard extends StatelessWidget {
  final ProductModel product;

  // ignore: use_key_in_widget_constructors
  const ProductTileCard({required this.product});

  @override
  Widget build(BuildContext context) {
    ProductProvider productprovider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        productprovider.product1 = product;
        print(product.name);
        Navigator.pushNamed(
          context,
          '/product-page',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.galleries![0].url.toString(),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
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
                    product.category!.name.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 12,
                      color: secondaryTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    product.name.toString(),
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '\$ ' + product.price.toString(),
                    style: priceTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
