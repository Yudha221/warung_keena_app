import 'package:flutter/material.dart';
import 'package:warung_keena_app/pages/auth/login_page.dart';
import 'package:warung_keena_app/pages/home/add_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2,
        flexibleSpace: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Dashboard',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, size: 24),
              title: const Text('Home'),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.food_bank, size: 24),
              title: const Text('Add Menu'),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, size: 24, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 13,
            ),
          ),
        ],
      ),
    );
  }
}
