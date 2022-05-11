import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';

// ignore: use_key_in_widget_constructors
class ChatBuble extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool hasProduct;

  // ignore: use_key_in_widget_constructors
  const ChatBuble(
      {required this.text, this.isSender = true, this.hasProduct = false});

  Widget productPreview(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      margin: const EdgeInsets.only(
        bottom: 12,
        right: 30,
        left: 30,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSender ? primaryColor.withOpacity(0.2) : backgroundColor4,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isSender ? 12 : 0),
          topRight: Radius.circular(isSender ? 0 : 12),
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images_examples_Shoes_1.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Court Vision Shoes',
                      maxLines: 2,
                      style: primaryTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '\$ 57.15',
                      style: priceTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                    color: primaryColor,
                  ),
                ),
                child: Text(
                  'Add to cart',
                  style: primaryTextStyle.copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Buy now',
                  style: primaryTextStyle.copyWith(
                    color: purpleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              hasProduct ? productPreview(context) : const SizedBox(),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.7), // widget constraints memungkinkan penggunanya untuk memberikan maxwidth, maxheight dan minwidth, minheight
                margin: const EdgeInsets.only(
                  right: 30,
                  left: 30,
                  bottom: 12,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: isSender
                      ? primaryColor.withOpacity(0.2)
                      : backgroundColor4,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSender ? 12 : 0),
                    topRight: Radius.circular(isSender ? 0 : 12),
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                  ),
                ),
                child: Text(
                  text,
                  style: primaryTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
