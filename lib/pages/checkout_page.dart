import 'package:bwa_shamo/models/cart_model.dart';
import 'package:bwa_shamo/providers/auth_provider.dart';
import 'package:bwa_shamo/providers/cart_provider.dart';
import 'package:bwa_shamo/providers/transaction_provider.dart';
import 'package:bwa_shamo/widgets/list_items_card.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<CartModel> cart = cartProvider.cart;

    handleCheckout() async {
      setState(() {
        isLoading = true;
      });
      if (await transactionProvider.transaction(
        token: authProvider.user.token.toString(),
        carts: cart,
        totalPrice: cartProvider.totalPrice(),
      )) {
        cart.clear();
        setState(() {
          isLoading = false;
        });
        Navigator.restorablePushNamedAndRemoveUntil(
            context, '/checkout-success-page', (route) => false);
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        elevation: 0,
        toolbarHeight: 87,
        centerTitle: true,
        backgroundColor: backgroundColor1,
        title: Text(
          'Checkout Details',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget paymentSummarySpacer(
        {required String name, required String description}) {
      return Container(
        margin: const EdgeInsets.only(
          top: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              description,
              style: primaryTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: const EdgeInsets.all(
          30,
        ),
        children: [
          // NOTE: List Items
          Text(
            'List Items',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            children: cart
                .map(
                  (cartItem) => ListItemsCard(cartItem),
                )
                .toList(),
          ),

          // NOTE: Address Details
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            padding: const EdgeInsets.all(
              20,
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
                Text(
                  'Address Details',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/icon_store.png',
                          width: 40,
                        ),
                        Image.asset(
                          'assets/Line 1.png',
                          height: 30,
                        ),
                        Image.asset(
                          'assets/Location Icon.png',
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Store Location',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Adidas Core',
                            // overflow: TextOverflow.ellipsis,
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Your Location',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Jalan Surabaya, Universitas Negeri Malang',
                            // overflow: TextOverflow.ellipsis,
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // NOTE: Payment Summary
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            padding: const EdgeInsets.all(
              20,
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
                Text(
                  'Payment Summary',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                paymentSummarySpacer(
                  name: 'Product Quantity',
                  description: cartProvider.totalItem().toString(),
                ),
                paymentSummarySpacer(
                  name: 'Product Price',
                  description: '\$${cartProvider.totalPrice()}',
                ),
                paymentSummarySpacer(
                  name: 'Shipping',
                  description: 'Free',
                ),
                const SizedBox(
                  height: 11,
                ),
                const Divider(
                  thickness: 2,
                  color: Color(0XFF2E3141),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: priceTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${cartProvider.totalPrice()}',
                      style: priceTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            thickness: 3,
            color: Color(0xff2B2938),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: TextButton(
              onPressed: handleCheckout,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                backgroundColor: primaryColor,
              ),
              child: isLoading == true
                  ? Container(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4,
                      ),
                    )
                  : Text(
                      'Checkout Now',
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      backgroundColor: backgroundColor3,
      body: content(),
    );
  }
}
