import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final int lastIndex;
  final int index;

  // ignore: use_key_in_widget_constructors
  ProductCard({
    required this.product,
    required this.lastIndex,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return GestureDetector(
      onTap: () {
        productProvider.product1 =
            product; //mengirim value product ke product-page

        Navigator.pushNamed(
          context,
          '/product-page',
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 30, right: index == lastIndex ? 30 : 0),
        width: 215,
        height: 278,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: productCardColor,
        ),
        child: Container(
          margin: const EdgeInsets.only(
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.galleries![0].url.toString(),
                width: MediaQuery.of(context).size.width,
                height: 120,
                fit: BoxFit.cover,
              ),
              Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    top: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category!.name.toString(),
                        style: primaryTextStyle.copyWith(
                          color: const Color(0xff999999),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        product.name.toString(),
                        style: primaryTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff2E2E2E),
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Membuat teks yang terlalu penuh menjadi '...'
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        '\$ ' + product.price.toString(),
                        style: priceTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
