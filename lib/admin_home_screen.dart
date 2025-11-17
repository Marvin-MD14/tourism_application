import 'package:flutter/material.dart';
import 'main.dart'; 
import 'tourist_spot_list_screen.dart'; 
import 'edit_profile_screen.dart'; 

class AdminHomeScreen extends StatelessWidget {
  final String username;
  final String email; 
  final String role; 
  
  const AdminHomeScreen({
    super.key, 
    required this.username, 
    required this.email, 
    required this.role,  
  });

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false, 
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context); 
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard (ADMIN)'), 
        backgroundColor:Colors.lightBlue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(email), 
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.security, size: 50, color: Colors.lightBlue),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade700, 
              ),
            ),
            
       
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('View Tourist Spot'),
              onTap: () => _navigateTo(context, const TouristSpotListScreen()),
            ),
           
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () => _navigateTo(context, EditProfileScreen(
                username: username,
                email: email,
                role: role,
            
                gender: 'Female',
                country: 'Philippines', 
              )), 
            ),
            
            
            ListTile(
              leading: const Icon(Icons.category, color: Colors.lightBlue),
              title: const Text('Manage Tourist Spots', style: TextStyle(color: Colors.red)),
              onTap: () {
                // TODO: Navigate to Admin spot management screen
                Navigator.pop(context);
              },
            ),

            const Divider(), 
            
            // 4. Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.lightBlue),
              title: const Text('Logout', style: TextStyle(color: Colors.lightBlue)),
              onTap: () => _logout(context), 
            ),
          ],
        ),
      ),
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.admin_panel_settings, size: 80, color: Colors.lightBlue),
            const SizedBox(height: 20),
            Text(
              'Welcome Back, Admin $username!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
            const SizedBox(height: 10),
            Text(
              'Your role: $role',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}