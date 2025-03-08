import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warung_keena_app/components/my_drawer_tile.dart';
import 'package:warung_keena_app/pages/auth/login_page.dart';
import 'package:warung_keena_app/pages/home/add_page.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onRefresh;

  const MyDrawer({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              width: 160,
              height: 150,
              child: SvgPicture.asset(
                'assets/icons/LogoWarung.svg',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // Home
          MyDrawerTile(
            text: 'Home',
            icon: Icons.home,
            textColor: Colors.white,
            iconColor: Colors.white,
            onTap: () => Navigator.pop(context),
          ),

          // Add Menu
          MyDrawerTile(
            text: 'ADD MENU',
            icon: Icons.food_bank,
            textColor: Colors.white,
            iconColor: Colors.white,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPage()),
              ).then((_) {
                onRefresh(); // Panggil refresh produk setelah kembali dari AddPage
              });
            },
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          // Log Out
          MyDrawerTile(
            text: 'Log Out',
            icon: Icons.logout,
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(onTap: () {}),
                ),
              );
            },
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
