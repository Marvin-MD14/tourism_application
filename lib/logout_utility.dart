import 'package:flutter/material.dart';
// IMPORTANTE: Siguraduhin na ito ang tamang path sa iyong utility file
import 'logout_utility.dart'; 

class HomeScreen extends StatelessWidget {
  final String username;
  final String email;
  final String role;
  // Iba pang fields...

  const HomeScreen({
    super.key,
    required this.username,
    required this.email,
    required this.role,
    // Iba pang required fields...
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // --- DITO ANG DRAWER (SIDEBAR MENU) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header (para sa user info)
            UserAccountsDrawerHeader(
              accountName: Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text(email),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person), // Pwede mong palitan ng Profile Image
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            // Iba pang menu items...
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Tourist Spots'),
              onTap: () {
                // TODO: Mag-navigate sa Tourist Spots Screen
                Navigator.pop(context); 
              },
            ),

            const Divider(), // Separator

            // --- LOGOUT BUTTON ---
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // TUMAWAG SA LOGOUT FUNCTION
                handleLogout(context); 
                // Isasara ang drawer pagkatapos tawagin ang function
                Navigator.pop(context); 
              },
            ),
          ],
        ),
      ),
      // --- END OF DRAWER ---
      
      body: const Center(
        child: Text('Ito ang Home Screen Content!'),
      ),
    );
  }
}