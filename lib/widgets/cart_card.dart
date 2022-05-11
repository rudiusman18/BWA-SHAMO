import 'package:bwa_shamo/models/cart_model.dart';
import 'package:bwa_shamo/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CartCard extends StatelessWidget {
  final CartModel cart;
  CartCard({required this.cart});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: const EdgeInsets.only(
        right: 30,
        left: 30,
        bottom: 12,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  cart.product.galleries![0].url.toString(),
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
                      cart.product.name.toString(),
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '\$${cart.product.price}',
                      style: priceTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(cart.id);
                      cartProvider.addQuantity(id: cart.id);
                    },
                    child: Image.asset(
                      'assets/icon_add_item.png',
                      width: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    cart.quantity.toString(),
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (cart.quantity > 1) {
                        cartProvider.reduceQuantity(id: 0);
                      } else {
                        cartProvider.removeCart(id: cart.id);
                      }
                    },
                    child: Image.asset(
                      'assets/icon_min_item.png',
                      width: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              cartProvider.removeCart(id: cart.id);
            },
            child: Row(
              children: [
                Icon(
                  Icons.delete_forever,
                  color: alertColor,
                  size: 18,
                ),
                Text(
                  'Remove',
                  style: primaryTextStyle.copyWith(
                    color: alertColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
