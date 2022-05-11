import 'dart:async';

import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getInit();

    super.initState();
  }

  Future getInit() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<ProductProvider>(context, listen: false).getProduct();
    await Provider.of<ProductProvider>(context, listen: false).getCategory();

    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon_splash_screen.png'),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            isLoading == true
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
