import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ChatTileCard extends StatelessWidget {
  final String imageName;
  final String storeName;
  final String latestChat;
  final String time; //sementara

  // ignore: use_key_in_widget_constructors
  const ChatTileCard({
    required this.imageName,
    required this.storeName,
    required this.latestChat,
    required this.time,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 25,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/' + imageName,
                width: 54,
                height: 54,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeName,
                      style: primaryTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      latestChat,
                      style: secondaryTextStyle.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: secondaryTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xff2B2939),
          ),
        ],
      ),
    );
  }
}
