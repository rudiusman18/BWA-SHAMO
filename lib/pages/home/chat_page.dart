import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:bwa_shamo/widgets/chat_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productprovider = Provider.of(context);
    Widget header() {
      return AppBar(
        elevation: 0,
        toolbarHeight: 87.0,
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false, //menghilangkan leading back
        centerTitle: true,
        title: Text(
          'Message Support',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    // ignore: unused_element
    Widget emptyChat() {
      return Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: backgroundColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_headset.png',
                width: 80,
                height: 80.5,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Oops no message yet!',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'You have never done a transaction',
                style: secondaryTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/main_page/home');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24,
                    ),
                  ),
                  child: Text(
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget chat() {
      return Expanded(
        child: Container(
          color: backgroundColor3,
          child: ListView(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  productprovider.setChatProduct = ProductModel();

                  Navigator.pushNamed(
                    context,
                    '/detail-page',
                  );
                },
                child: const ChatTileCard(
                  imageName: 'image_shop_picture.png',
                  storeName: 'BWA Shoes',
                  latestChat:
                      'You\'ve already purchased this item, would you like to purchase again?',
                  time: 'NOW',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        //emptyChat(), // kondisi tampilan jika chat sedang kosong
        chat(),
      ],
    );
  }
}
