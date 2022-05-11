import 'package:bwa_shamo/providers/wishlist_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:bwa_shamo/widgets/wishlist_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    Widget header() {
      return AppBar(
        automaticallyImplyLeading: false, // menghilangkan leading
        title: Text(
          'Favorite Shoes',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: backgroundColor1,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 87,
      );
    }

    // ignore: unused_element
    Widget emptyWishlist() {
      return Container(
        color: backgroundColor3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_wishlist_blue.png',
              width: 74,
              height: 62,
            ),
            const SizedBox(
              height: 23,
            ),
            Text(
              'You don\'t have dream shoes?',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Let\'s find your favorite shoes',
              style: secondaryTextStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 24,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/main_page');
                },
                child: Text(
                  'Explore Store',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
            padding: const EdgeInsets.only(
              top: 30,
              right: 30,
              left: 30,
            ),
            color: backgroundColor3,
            child: wishlistProvider.wishlist.isEmpty
                ? emptyWishlist()
                : ListView(
                    children: wishlistProvider.wishlist
                        .map(
                          (e) => WishlistTileCard(
                            product: e,
                          ),
                        )
                        .toList(),
                  )),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
