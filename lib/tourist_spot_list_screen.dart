import 'package:flutter/material.dart';


const Color primaryAccentColor = Color(0xFF336699); 

class TouristSpotListScreen extends StatelessWidget {
  const TouristSpotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tourist Spots', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'Under Construction: Full List View',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}