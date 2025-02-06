import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;
  final Color? textColor;
  final Color? iconColor;

  const MyDrawerTile({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.textColor, // Tambahkan parameter warna teks
    this.iconColor, // Tambahkan parameter warna ikon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(
              color: textColor ?? Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: Icon(
          icon,
          color: iconColor ?? Theme.of(context).colorScheme.inversePrimary,
        ),
        onTap: onTap,
      ),
    );
  }
}
