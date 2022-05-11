import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:bwa_shamo/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class DetailChatPage extends StatefulWidget {
  @override
  _DetailChatPageState createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productprovider = Provider.of<ProductProvider>(context);
    Widget header() {
      return AppBar(
        toolbarHeight: 80,
        backgroundColor: backgroundColor1,
        title: Row(
          children: [
            Image.asset(
              'assets/icon_shop_chat_online.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BWA Shoes',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Online',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // ignore: unused_element
    Widget previewProduct() {
      return Container(
        margin: const EdgeInsets.only(
          left: 20,
        ),
        width: 225,
        height: 74,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.2),
          border: Border.all(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${productprovider.chatProduct.galleries!.first.url}',
                  width: 54,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productprovider.chatProduct.name}',
                    style: primaryTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\$${productprovider.chatProduct.price}',
                    style: priceTextStyle,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                top: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    productprovider.setChatProduct = ProductModel();
                  });
                },
                child: Image.asset(
                  'assets/icon_cross.png',
                  width: 22,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget inputChat() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: backgroundColor4,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: TextFormField(
                    style: primaryTextStyle,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type Something...',
                      hintStyle: subtitleTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 45,
                height: 45,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  primary: primaryColor,
                ),
                child: Image.asset(
                  'assets/icon_send.png',
                  width: 19,
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }

    print(productprovider.chatProduct.name);
    return Scaffold(
      appBar: PreferredSize(
        child: header(),
        preferredSize: const Size.fromHeight(70),
      ),
      backgroundColor: backgroundColor3,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              children: const [
                ChatBuble(
                  text: 'Hi, this item is still available?',
                  isSender: true,
                  hasProduct: true,
                ),
                ChatBuble(
                  text: 'yes, this item is still available with size 42',
                  isSender: false,
                ),
                ChatBuble(
                  text: 'Owww, it suits me very well',
                  isSender: true,
                )
              ],
            ),
          ),
          productprovider.chatProduct.name == null
              ? Container()
              : previewProduct(), // ini adalah fungsi yang menampilkan buble product,
          inputChat(),
        ],
      ),
    );
  }
}
