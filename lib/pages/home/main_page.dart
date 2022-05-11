import 'package:bwa_shamo/pages/home/profile_page.dart';
import 'package:bwa_shamo/pages/home/wishlist_page.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'home_page.dart';

// ignore: use_key_in_widget_constructors
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    // membuat cart button
    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart-page');
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

// membuat bottom nav bar secara custom
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            backgroundColor: bottomNavbarColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    'assets/icon_home.png',
                    width: 21,
                    color: index == 0 ? primaryColor : unactiveIcon,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    'assets/icon_chat.png',
                    width: 20,
                    color: index == 1 ? primaryColor : unactiveIcon,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    'assets/icon_wishlist.png',
                    width: 20,
                    color: index == 2 ? primaryColor : unactiveIcon,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Image.asset(
                    'assets/icon_profile.png',
                    width: 18,
                    color: index == 3 ? primaryColor : unactiveIcon,
                  ),
                ),
                label: "",
              ),
            ],
          ),
        ),
      );
    }

// mengarahkan pada halaman tertentu
    Widget body() {
      switch (index) {
        case 0:
          return HomePage();
        case 1:
          return ChatPage();
        case 2:
          return WishlistPage();
        case 3:
          return ProfilePage();
        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
