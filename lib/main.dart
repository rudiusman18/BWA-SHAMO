import 'package:bwa_shamo/pages/cart_page.dart';
import 'package:bwa_shamo/pages/checkout_page.dart';
import 'package:bwa_shamo/pages/checkout_success_page.dart';
import 'package:bwa_shamo/pages/home/detail_chat_page.dart';
import 'package:bwa_shamo/pages/home/edit_profile_page.dart';
import 'package:bwa_shamo/pages/home/main_page.dart';
import 'package:bwa_shamo/pages/home/order_page.dart';
import 'package:bwa_shamo/pages/login_page.dart';
import 'package:bwa_shamo/pages/product/product_page.dart';
import 'package:bwa_shamo/pages/register_page.dart';
import 'package:bwa_shamo/providers/auth_provider.dart';
import 'package:bwa_shamo/providers/cart_provider.dart';
import 'package:bwa_shamo/providers/page_provider.dart';
import 'package:bwa_shamo/providers/product_provider.dart';
import 'package:bwa_shamo/providers/transaction_provider.dart';
import 'package:bwa_shamo/providers/wishlist_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bwa_shamo/pages/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        )
      ],
      child: MaterialApp(
        title: 'BWA Shamo',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return PageTransition(
                child: LoginPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/register':
              return PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.rightToLeft,
              );

            case '/after_register':
              return PageTransition(
                child: LoginPage(),
                type: PageTransitionType.leftToRight,
              );
            case '/main_page':
              return PageTransition(
                child: MainPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/main_page/home':
              return PageTransition(
                child: MainPage(),
                type: PageTransitionType.fade,
              );

            case '/detail-page':
              return PageTransition(
                child: DetailChatPage(),
                type: PageTransitionType.bottomToTop,
              );

            case '/edit-profile':
              return PageTransition(
                child: EditProfilePage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/product-page':
              return PageTransition(
                child: ProductPage(),
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
              );
            case '/cart-page':
              return PageTransition(
                child: CartPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/checkout-page':
              return PageTransition(
                child: CheckoutPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/checkout-success-page':
              return PageTransition(
                child: CheckoutSuccessPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/order-page':
              return PageTransition(
                child: OrderPage(),
                type: PageTransitionType.rightToLeft,
              );
            default:
              return null;
          }
        },
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),

          // '/register': (context) => Register(),
        },
      ),
    );
  }
}
