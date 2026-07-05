import 'package:flutter/material.dart';
import 'package:fruit_store_app/models/fruit_model.dart';
import 'package:fruit_store_app/screens/cart_screen.dart';
import 'package:fruit_store_app/screens/fruit_detail_screen.dart';
import 'package:fruit_store_app/screens/fruit_list_screen.dart';
import 'package:fruit_store_app/screens/history_screen.dart';
import 'package:fruit_store_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toko Buah Segar',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const FruitListScreen(),
        '/cart': (context) => const CartScreen(),
        '/history': (context) => const HistoryScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final fruit = settings.arguments as Fruit;
          return MaterialPageRoute(
            builder: (context) => FruitDetailScreen(fruit: fruit),
          );
        }
        return null;
      },
    );
  }
}