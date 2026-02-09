import 'package:easy_mart/view/screens/splash.dart';
import 'package:easy_mart/viewmodels/cart_provider.dart';
import 'package:easy_mart/viewmodels/category_provider.dart';
import 'package:easy_mart/viewmodels/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProductProvider(),),
    ChangeNotifierProvider(create: (_) => CartProvider(),),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),









  ],child: MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
