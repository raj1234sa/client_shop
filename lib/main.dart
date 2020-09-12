import 'package:client_shop/providers/product_provider.dart';
import 'package:client_shop/screens/notification_screen.dart';
import 'package:client_shop/screens/product_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/notification_screen.dart';
import 'screens/product_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ProductProvider.initProducts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Abhi Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ProductListScreen.routeName,
        routes: {
          ProductListScreen.routeName: (context) => ProductListScreen(),
          NotificationScreen.routeName: (context) => NotificationScreen(),
        },
      ),
    );
  }
}
