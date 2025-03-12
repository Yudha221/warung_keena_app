import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warung_keena_app/auth/login_or_register.dart';
import 'package:warung_keena_app/providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CartProvider()), //  Tambahkan ini
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
    );
  }
}
