import 'package:bwa_shamo/providers/auth_provider.dart';
import 'package:bwa_shamo/providers/transaction_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = true;

  void iniState() {
    getInit();
    super.initState();
  }

  void getInit({String? token}) async {
    await Provider.of<TransactionProvider>(context)
        .getTransactionItem(token: token.toString());
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    getInit(token: authProvider.user.token.toString());

    PreferredSizeWidget orderHeader() {
      return AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          'Your Order',
          style: primaryTextStyle,
        ),
        centerTitle: true,
      );
    }

    Widget productTileCard({
      String? name,
      String? status,
      String? price,
      String? quantity,
      String? imgUrl,
    }) {
      return GestureDetector(
        onTap: () {
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
                  imgUrl.toString(),
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
                      status.toString(),
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
                      name.toString(),
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '\$ ' + price.toString(),
                      style: priceTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                quantity.toString(),
                style: primaryTextStyle,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: orderHeader(),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : ListView(
              children: transactionProvider.productItem
                  .map((e) => Column(
                          children: e.transactionitem!.map(
                        (a) {
                          return productTileCard(
                            name: a.product!.name,
                            status: e.status,
                            imgUrl: a.productgallery!.imgUrl,
                            price: e.totalPrice,
                            quantity: a.quantity.toString(),
                          );
                        },
                      ).toList()))
                  .toList(),
            ),
    );
  }
}
