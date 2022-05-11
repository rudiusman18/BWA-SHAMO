import 'package:bwa_shamo/models/category_model.dart';
import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/models/user_model.dart';
import 'package:bwa_shamo/providers/auth_provider.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:bwa_shamo/widgets/product_card.dart';
import 'package:bwa_shamo/widgets/product_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    UserModel user = authProvider.user;
    List<ProductModel> product = productProvider.product;
    List<CategoryModel> category = productProvider.category;
    int index = -1;
    int popularProductIndex = 0;

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // Expanded merupakan sebuah widget yang memperluas child dari Row, Column, atau flex sehingga mengisi ruang yang tersedia. Dengan menggunakan expanded widget, membuat children dari Row, Column, atau flex meluas mengisi ruang yang tersedia di sepanjang sumbu utama (baik secara vertical maupun horizontal) (menghindari overflow)
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ' + user.name,
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '@' + user.username,
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            ClipOval(
              child: Image.network(
                user.profilePhotoUrl,
                width: 54,
                height: 54,
              ),
            ),
          ],
        ),
      );
    }

    Widget categoryItem(CategoryModel category, int indeks, int length) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = indeks;
            print(selectedIndex);
          });
        },
        onDoubleTap: () {
          setState(() {
            selectedIndex = -1;
          });
        },
        child: Container(
          margin:
              EdgeInsets.only(right: indeks >= 0 && indeks < length ? 16 : 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  selectedIndex == indeks ? Colors.transparent : subtitleColor,
            ),
            color: selectedIndex == indeks ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            category.name.toString(),
            style: selectedIndex == indeks
                ? primaryTextStyle.copyWith(fontWeight: FontWeight.w500)
                : subtitleTextStyle.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
        child: Text('Popular Products',
            style: primaryTextStyle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )),
      );
    }

    Widget popularProducts() {
      return Container(
        // ignore: prefer_const_constructors
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: product.map((item) {
              popularProductIndex++;
              return ProductCard(
                product: item,
                index: popularProductIndex,
                lastIndex: product.length,
              );
            }).toList(),
          ),
        ),
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: const EdgeInsets.only(
          top: 30,
          left: 30,
        ),
        child: Text('New Arrivals',
            style: primaryTextStyle.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            )),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: const EdgeInsets.only(
          top: 14,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product
                .map(
                  (item) => ProductTileCard(
                    product: item,
                  ),
                )
                .toList()),
      );
    }

// kode dibawah ditampilkan kedalam UI (User Interface)
    return SafeArea(
      child: ListView(
        children: [
          header(),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: category.map((value) {
                  index++;
                  return categoryItem(value, index, category.length);
                }).toList(),
              ),
            ),
          ),
          popularProductsTitle(),
          popularProducts(),
          newArrivalsTitle(),
          newArrivals(),
        ],
      ),
    );
  }
}
