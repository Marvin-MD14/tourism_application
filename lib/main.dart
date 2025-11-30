import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Tiyaking meron ka nitong tatlong files sa 'lib/' folder
import 'registration_screen.dart'; 
import 'home_screen.dart'; 
import 'admin_home_screen.dart'; 

// GUMAGAMIT NA NG LIVE DOMAIN URL
const String loginApiUrl = "https://islanddigitalguide.com/catanduanes_api/login.php"; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Island Digital Guide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade700),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Future<void> _loginUser() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showSnackBar("Please enter both email and password.", isError: true);
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final response = await http.post(
        Uri.parse(loginApiUrl),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data['status'] == 'success') {
          String userName = data['username']?.toString() ?? '';
          String userEmail = data['email']?.toString() ?? '';
          String userRole = data['role']?.toString() ?? 'user'; 
          String userGender = data['gender']?.toString() ?? ''; 
          String userCountry = data['country']?.toString() ?? '';
          String? profileImageUrl = data['profile_image_url']?.toString(); 

          _passwordController.clear();
          
          if (userRole.toLowerCase() == 'admin') { 
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminHomeScreen(
                    username: userName,
                    email: userEmail, 
                    role: userRole, 
                  ), 
                ),
              );
          } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    username: userName,
                    email: userEmail, 
                    role: userRole, 
                    gender: userGender, 
                    country: userCountry, 
                    profileImageUrl: profileImageUrl,
                  ), 
                ),
              );
          }
        } else {
          _showSnackBar('Login Failed: ${data['message']}', isError: true);
        }
      } else {
        _showSnackBar('Server Error! Status: ${response.statusCode}', isError: true);
      }
    } catch (e) {
      // UPDATED ERROR MESSAGE: Gumagamit ng live URL.
      _showSnackBar('Connection Error: Make sure your API is accessible at $loginApiUrl. Error: ${e.toString()}', isError: true);
    } finally {
      if (mounted) {
        setState(() { _isLoading = false; });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final formWidth = screenWidth > 600 ? 400.0 : screenWidth * 0.9;
    
    return Scaffold(
      appBar: AppBar(
        // INALIS ANG CONST SA ROW DAHIL SA 'ILLEGAL CHARACTER' ISSUE
        title: Row( 
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[ // Ginamit ang const dito sa children
            Icon(Icons.public_sharp, size: 28), 
            SizedBox(width: 8),
            Text('Island Digital Guide'),
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: formWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                
                  // --- LOGO PNG DITO ---
                  Center(
                    child: Image.asset(
                      'assets/island1.png',
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 2),
                  
                  const Center(
                    child: Text('Welcome to Island Digital Guide', 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                  ),
                  const SizedBox(height: 10),
                  
      const Center(
                    child: Text(
                      'Login to explore Catanduanes.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 40),

                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),

                  _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('LOGIN', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                  const SizedBox(height: 20),
                  
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Register here.",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}