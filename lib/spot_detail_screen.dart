

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart'; 



const Color primaryAccentColor = Color(0xFF336699); 
const Color secondaryAccentColor = Color(0xFFF0F5EC); 

class SpotDetailScreen extends StatelessWidget {
  final String spotName;
  final String imagePath;
  final String basicInfo;
  final String destinationInfo;
  final String mapUrlPlaceholder; 

  const SpotDetailScreen({
    super.key,
    required this.spotName,
    required this.imagePath,
    required this.basicInfo,
    required this.destinationInfo,
    required this.mapUrlPlaceholder,
  });

 
  WebViewController get _mapController {
    final String htmlContent = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      </head>
      <body style="margin: 0; padding: 0;">
        <iframe
          src="$mapUrlPlaceholder" 
          width="100%"
          height="100%"
          style="border:0;"
          allowfullscreen=""
          loading="lazy"
          referrerpolicy="no-referrer-when-downgrade">
        </iframe>
      </body>
      </html>
    ''';

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error loading map: ${error.description}');
          },
        ),
      );

    controller.loadHtmlString(htmlContent);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spotName, style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildImageHeader(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSpotHeader(),
                  const SizedBox(height: 15),

              
                  _buildInfoCard(
                    icon: Icons.article,
                    iconColor: Colors.blue.shade600,
                    title: 'Basic Information',
                    content: basicInfo,
                  ),
                  const SizedBox(height: 20),

            
                  _buildInfoCard(
                    icon: Icons.rocket_launch,
                    iconColor: Colors.red.shade600,
                    title: 'How to Get There',
                    content: destinationInfo,
                  ),
                  const SizedBox(height: 20),

           
                  _buildReviewSection(),
                  const SizedBox(height: 20),

               
                  _buildLocationMapSection(context),
                  const SizedBox(height: 30),

                
                  _buildSearchButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildImageHeader() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade300,
          child: Center(
            child: Text('Image Not Found: $spotName', style: const TextStyle(color: Colors.red)),
          ),
        ),
      ),
    );
  }

  Widget _buildSpotHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          spotName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: primaryAccentColor,
          ),
        ),
        const Row(
          children: [
            Icon(Icons.location_on, color: Colors.black54, size: 18),
            SizedBox(width: 4),
            Text(
              'Catanduanes, Philippines',
              style: TextStyle(fontSize: 16, color: Colors.black54, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        const Divider(height: 25, color: primaryAccentColor),
      ],
    );
  }

  Widget _buildInfoCard({required IconData icon, required Color iconColor, required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: iconColor)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5), textAlign: TextAlign.justify),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 24),
            SizedBox(width: 8),
            Text('Guest Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
          ],
        ),
        const SizedBox(height: 10),
        _buildReviewItem(
          icon: Icons.chat_bubble_outline,
          color: secondaryAccentColor, 
          title: 'Amazing place!',
          subtitle: 'The location of $spotName was breathtaking. - SurferBoy', 
        ),
        _buildReviewItem(
          icon: Icons.history,
          color: Colors.lightGreen.shade100, 
          title: 'Rich History',
          subtitle: 'The local culture is fascinating. Highly recommended. - L. Cruz',
        ),
      ],
    );
  }

  Widget _buildReviewItem({required IconData icon, required Color color, required String title, required String subtitle}) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: primaryAccentColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildLocationMapSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.location_on, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Location Map (Embedded View)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: primaryAccentColor.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                WebViewWidget(controller: _mapController), 
                
              
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _navigateToFullMap(context),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          color: primaryAccentColor.withOpacity(0.8),
                          child: const Center(
                            child: Text(
                              'Tap to View Full Map', 
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
        
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigating to All Tourist Spots...')),
          );
        },
        icon: const Icon(Icons.search, color: Colors.white),
        label: const Text(
          'Search More Places in Catanduanes',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccentColor,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
        ),
      ),
    );
  }

  void _navigateToFullMap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenMapModal(
          mapUrlPlaceholder: mapUrlPlaceholder,
          spotName: spotName,
        ),
      ),
    );
  }
}



class FullScreenMapModal extends StatelessWidget {
  final String mapUrlPlaceholder;
  final String spotName;

  const FullScreenMapModal({
    super.key,
    required this.mapUrlPlaceholder,
    required this.spotName,
  });

 
  WebViewController get _fullMapController {
    final String htmlContent = '''
      <!DOCTYPE html>
      <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      </head>
      <body style="margin: 0; padding: 0;">
        <iframe
          src="$mapUrlPlaceholder" 
          width="100%"
          height="100%"
          style="border:0;"
          allowfullscreen=""
          loading="lazy"
          referrerpolicy="no-referrer-when-downgrade">
        </iframe>
      </body>
      </html>
    ''';

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error loading map in modal: ${error.description}');
          },
        ),
      );

 
    controller.loadHtmlString(htmlContent);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Map View: $spotName', style: const TextStyle(color: Colors.white)),
        backgroundColor: primaryAccentColor,
        foregroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: _fullMapController), // FIXED: Display ang WebViewWidget
    );
  }
}