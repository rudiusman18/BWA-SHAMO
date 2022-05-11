import 'package:bwa_shamo/models/product_model.dart';
import 'package:bwa_shamo/providers/cart_provider.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/providers/wishlist_provider.dart';
import 'package:bwa_shamo/widgets/familiar_products_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isWishlist =
      false; //untuk mengubah icon wishlist menjadi true tertekan atau tidak

  int currentIndex =
      0; //variabel yang digunakan untuk mengetahui sedang berada di index ke berapa

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    ProductModel product = productProvider.product1;

    final List<Widget> imageSliders = product.galleries!
        .map(
          (item) => Image.network(
            item.url.toString(),
            fit: BoxFit.cover,
            width: 300,
          ),
        )
        .toList();

    Widget indicator(int index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(4),
              width: currentIndex == index ? 16 : 4,
              height: 4,
              decoration: BoxDecoration(
                color: currentIndex == index ? primaryColor : backgroundColor6,
                borderRadius: BorderRadius.circular(10),
              )),
        ],
      );
    }

    Future<void> alertDialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: backgroundColor3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              insetPadding: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(
                            0xffF1F0F2,
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/image_success.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Hurray :)',
                      style: primaryTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Item added succesfully',
                      style: secondaryTextStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        color: primaryColor,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            '/cart-page',
                          );
                        },
                        child: Text(
                          'View my Cart',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          });
    }

    Widget header() {
      int indeks = -1;
      return SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }, //fungsi onPageChanged, dimana currentIndex
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageSliders.map((e) {
                    indeks++;
                    return indicator(indeks);
                  }).toList(), //fungsi untuk menghitung jumlah foto lalu diubah kedalam bentuk indikator (mirip seperti fungsi perulangan pada bahasa lain)
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 30,
                right: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  const Icon(
                    Icons.shopping_bag,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(
              24,
            ),
          ),
          color: backgroundColor1,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name.toString().toUpperCase(),
                              style: primaryTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              product.category!.name.toString(),
                              style: secondaryTextStyle.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            wishlistProvider.setProduct(product);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor:
                                    wishlistProvider.isWishlist(product)
                                        ? secondaryColor
                                        : alertColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                ),
                                content: Text(
                                  wishlistProvider.isWishlist(product)
                                      ? 'Has been added to wishlist!'
                                      : 'Has been deleted from wishlist!',
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          );
                        },
                        child: Image.asset(
                          wishlistProvider.isWishlist(product)
                              ? 'assets/icon_favourite_blue.png'
                              : 'assets/icon_favourite.png',
                          width: 46,
                          height: 46,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                      color: backgroundColor2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price Starts From',
                          style: primaryTextStyle,
                        ),
                        Text(
                          '\$' + product.price.toString(),
                          style: priceTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Description',
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    Html(data: """${product.description!.replaceAll('</div>', '').replaceAll('<div>', '')}""")
                        .data
                        .toString(),
                    style: subtitleTextStyle.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Familiar Shoes',
                    style: primaryTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  children: product.galleries!
                      .map(
                        (image) =>
                            FamiliarProductsTileCard(image.url.toString()),
                      )
                      .toList(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        productProvider.setChatProduct = product;
                      });
                      Navigator.pushNamed(context, '/detail-page');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: primaryColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/icon_chat.png',
                          color: primaryColor,
                          width: 23,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        cartProvider.addCart(product: product);
                        alertDialog();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: primaryTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor5,
      body: ListView(
        children: [
          header(),
          const SizedBox(
            height: 17,
          ),
          content(),
        ],
      ),
    );
  }
}

/*
CATATAN: 
Untuk membuat indicator pada product_page langkah yang digunakan adalah sebagai berikut: 
1. Buat widget indikator, dan berikan parameter pada fungsinya (parameter ini akan berfungsi untuk mengetahui foto terletak pada index ke berapa)
2. buat variabel global (pada halaman ini namanya adalah currentIndex), variabel tersebut akan digunakan untuk mengambil nilai dari foto tersebut sedang berada di index ke berapa menggunakan atribut onpageChanged (statefulwidget)
3. buat variabel didalam widget (pada file berada pada widget header) untuk mendeteksi ada berapa foto yang akan ditampilkan, sehingga indicator akan otomatis tampil sebanyak foto yang ditampilkan

*/