

import 'package:flutter/material.dart';
import 'package:tourism_application/edit_profile_screen.dart';
import 'package:tourism_application/spot_detail_screen.dart';
import 'package:tourism_application/models/tourist_spot.dart';

// Color Schemes
const Color primaryAccentColor = Color(0xFF336699);
const Color secondaryAccentColor = Color(0xFFF0F5EC);


class PlaceholderLoginScreen extends StatelessWidget {
  const PlaceholderLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: const Center(child: Text('Login Screen Placeholder')),
    );
  }
}


class PlaceholderTouristSpotListScreen extends StatelessWidget {
  const PlaceholderTouristSpotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tourist Spots')),
      body: const Center(child: Text('Tourist Spot List Screen')),
    );
  }
}


class Municipality {
  final String name;
  final String description;
  final String iconPath;

  const Municipality({
    required this.name,
    required this.description,
    required this.iconPath,
  });
}

class HomeScreen extends StatefulWidget {
  final String username;
  final String email;
  final String role;
  final String gender;
  final String country;
  final String? profileImageUrl;

  const HomeScreen({
    super.key,
    required this.username,
    required this.email,
    required this.role,
    required this.gender,
    required this.country,
    this.profileImageUrl,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _currentUsername;
  late String _currentGender;
  late String _currentCountry;
  late String? _currentImageUrl;

  final List<Municipality> _municipalities = const [
    Municipality(
        name: 'Virac',
        description: 'The capital and commercial center of Catanduanes.',
        iconPath: 'assets/logos/virac.png'),
    Municipality(
        name: 'Viga',
        description: 'Known for its natural springs and extensive rice fields.',
        iconPath: 'assets/logos/viga.png'),
    Municipality(
        name: 'Baras',
        description: 'Home to Puraran Beach, famous among surfers.',
        iconPath: 'assets/logos/baras.png'),
    Municipality(
        name: 'Bato',
        description: 'Features the historic Bato Church.',
        iconPath: 'assets/logos/bato.png'),
    Municipality(
        name: 'Caramoran',
        description: 'A tranquil town on the western side.',
        iconPath: 'assets/logos/caramoran.png'),
    Municipality(
        name: 'Pandan',
        description: 'Located at the northernmost tip.',
        iconPath: 'assets/logos/pandan.png'),
    Municipality(
        name: 'Bagamanoc',
        description: 'Popular for its unique rock formations.',
        iconPath: 'assets/logos/bagamanoc.png'),
    Municipality(
        name: 'Panganiban',
        description: 'One of the thoroughfares to Central Catanduanes.',
        iconPath: 'assets/logos/panganiban.png'),
    Municipality(
        name: 'San Andres',
        description: 'A busy port town and a key gateway.',
        iconPath: 'assets/logos/sanandres.png'),
    Municipality(
        name: 'San Miguel',
        description: 'An inland municipality with mountain views.',
        iconPath: 'assets/logos/sanmiguel.png'),
    Municipality(
        name: 'Gigmoto',
        description: 'Located in the southeast, known for its caves.',
        iconPath: 'assets/logos/gigmoto.png'),
  ];
  final List<TouristSpot> _featuredSpots = const [
    TouristSpot(
      id: 1,
      name: 'Luyang Cave',
      description:
          'A historically significant cave in San Andres, Catanduanes, known for serving as a refuge during the Spanish era and a tragic site for locals.',
      travelGuide:
          'Best reached by hiring a tricycle from the town center; the cave entrance is a short walk from the main road.',
      rating: 4.5,
      imageUrl: 'assets/luyang.jpg',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3877.76271269662!2d124.29449217556525!3d13.610472124297067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a1e2025ed91d79%3A0x6b4ac053e1a37c03!2sBatong%20Paluway%20Church!5e0!3m2!1sen!2sph!4v1701389279075!5m2!1sen!2sph',
    ),

    TouristSpot(
      id: 2,
      name: 'Bato Church',
      description:
          'Nestled in the heart of Bato, Catanduanes, Bato Church, also known as St. John the Baptist Church, boasts a rich history dating back to the Spanish colonial era. Its construction began in the early 19th century, around 1830, under the supervision of Augustinian friars.',
      travelGuide: 'Accessible from Virac via bus or jeepney.',
      rating: 4.7,
      imageUrl: 'assets/bato.png',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3877.76271269662!2d124.29449217556525!3d13.610472124297067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a1e2025ed91d79%3A0x6b4ac053e1a37c03!2sBato%20Church!5e0!3m2!1sen!2sph!4v1701389279075!5m2!1sen!2sph',
    ),

    TouristSpot(
      id: 3,
      name: 'Batong Paluway',
      description:
          'A miraculous stone believed to bear the image of the Our Lady of Sorrows, attracting devotees especially during the annual fiesta celebration.',
      travelGuide:
          'Accessible via tricycle or motorcycle followed by a short uphill walk.',
      rating: 4.9,
      imageUrl: 'assets/batongpaluway.png',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3877.76271269662!2d124.29449217556525!3d13.610472124297067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a1e2025ed91d79%3A0x6b4ac053e1a37c03!2sBinurong%20Point!5e0!3m2!1sen!2sph!4v1701389279075!5m2!1sen!2sph',
    ),

    // ---------------------------
    // ⭐ NEW SPOT 1 — BINURONG POINT
    // ---------------------------
    TouristSpot(
      id: 4,
      name: 'Virac Cathedral,Immaculate Conception Parish',
      description:
          'The Church of the Immaculate Conception also known as “Virac Cathedral”, situated at the heart of the capital town of Virac, remains a lasting proof to the deep faith of Viracnons and is an architectural heritage that is constantly being adored by locals and visitors alike.',
      travelGuide:
          'The Cathedral is walking distance from most hotels and major establishments in the central business district.',
      rating: 4.7,
      imageUrl: 'assets/cathedral.JPG',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3878.277633572203!2d124.2278521112808!3d13.579842301195187!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a016c55bca4a65%3A0x9136275929a09a86!2sCathedral%20of%20the%20Immaculate%20Conception%20(Roman%20Catholic%20Diocese%20of%20Virac)!5e0!3m2!1sen!2sph!4v1763384721104!5m2!1sen!2sph',
    ),

    // ---------------------------
    // ⭐ NEW SPOT 2 — PURARAN BEACH
    // ---------------------------
    TouristSpot(
      id: 5,
      name: 'Batalay Shrine',
      description:
          'Batalay Shrine or also known as The Site of the First Cross in Catanduanes is located in Brgy. Batalay in the town of Bato, Catanduanes, and it is believed to have been constructed over the grave of the shipwrecked Fr. Diego de Herrera of the Augustinian Order in 1576 and well believed that a spring of clear water sprouted near the cross having healing powers',
      travelGuide:
          'There will be a relatively short walk or a climb up a few concrete stairs to reach the main cross and the chapel structure.',
      rating: 4.8,
      imageUrl: 'assets/shrine.jpeg',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3878.141488499213!2d124.31276231128098!3d13.588166501004572!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a0103a0e0f56d7%3A0x5f6d826b6941bfe6!2sDiocesan%20Shrine%20of%20the%20Holy%20Cross%20-%20Batalay%2C%20Bato%2C%20Catanduanes%20(Diocese%20of%20Virac)!5e0!3m2!1sen!2sph!4v1763384994697!5m2!1sen!2sph',
    ),

    // ---------------------------
    // ⭐ NEW SPOT 3 — MARIBINA FALLS
    // ---------------------------
    TouristSpot(
      id: 6,
      name: 'Bote Lighthouse',
      description:
          'Situated in Brgy. Bote in the town of Bato, the Bote Lighthouse gives you an astonishing view of Sakahon Beach and other parts of the island and gives you a glimpse of Mayon Volcano from afar. It is a 30-45 minute climb/trek from Sakahon Beach. It is tiring when you climb up to the Bote Lighthouse but you will feel satisfied when you are already at the top witnessing the scenic view of the pacific and other places in the province.',
      travelGuide:
          'Trek Duration: The climb up the hill will take 30 to 45 minutes, depending on your pace.',
      rating: 4.7,
      imageUrl: 'assets/lighthouse.JPG',
      mapUrlPlaceholder:
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3878.609613816691!2d124.32289901128073!3d13.55952330165985!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x33a011dc2758950f%3A0xba7d6decd1e55ba7!2sBote%20Lighthouse!5e0!3m2!1sen!2sph!4v1763385219473!5m2!1sen!2sph',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentUsername = widget.username;
    _currentGender = widget.gender;
    _currentCountry = widget.country;
    _currentImageUrl = widget.profileImageUrl;
  }

  void _navigateToSpotDetail(TouristSpot spot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpotDetailScreen(
          spotName: spot.name,
          imagePath: spot.imageUrl,
          basicInfo: spot.description,
          destinationInfo: spot.travelGuide,
          mapUrlPlaceholder: spot.mapUrlPlaceholder,
        ),
      ),
    );
  }

  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          username: _currentUsername,
          email: widget.email,
          role: widget.role,
          gender: _currentGender,
          country: _currentCountry,
          profileImageUrl: _currentImageUrl,
        ),
      ),
    );

    if (result != null &&
        result is Map<String, dynamic> &&
        result['status'] == 'success' &&
        mounted) {
      setState(() {
        _currentUsername = result['newUsername'] ?? _currentUsername;
        _currentGender = result['newGender'] ?? _currentGender;
        _currentCountry = result['newCountry'] ?? _currentCountry;
        _currentImageUrl = result['newImageUrl'] ?? _currentImageUrl;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  Widget _buildMunicipalitiesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.flag, color: primaryAccentColor),
              SizedBox(width: 8),
              Text(
                'The 11 Municipalities of Catanduanes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryAccentColor),
              ),
            ],
          ),
        ),
        ..._municipalities.map(
          (muni) => Card(
            margin: const EdgeInsets.only(bottom: 8.0),
            elevation: 2,
            child: ListTile(
              leading: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  muni.iconPath,
                  width: 40,
                  height: 40,
                  errorBuilder: (c, e, s) => const Icon(Icons.location_city,
                      color: primaryAccentColor, size: 30),
                ),
              ),
              title:
                  Text(muni.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(muni.description),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Viewing information for ${muni.name}')),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSpotsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(Icons.pin_drop, color: Colors.red),
              SizedBox(width: 8),
              Text(
                'Featured Tourist Spots',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ],
          ),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: _featuredSpots.length,
          itemBuilder: (context, index) {
            final spot = _featuredSpots[index];
            return GestureDetector(
              onTap: () => _navigateToSpotDetail(spot),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        spot.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Text('Image Not Found: ${spot.name}'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text(spot.rating.toString(),
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBriefHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.access_time_filled, color: primaryAccentColor),
            SizedBox(width: 8),
            Text(
              'Brief History',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryAccentColor),
            ),
          ],
        ),
        const Divider(height: 15),
        const Text(
          'Catanduanes was one of the earliest provinces recorded in the history of the Bicol region. It became a separate province on September 26, 1945, through Commonwealth Act No. 687. The island is rich in culture and a history of resilience against typhoons.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            'assets/island.png',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              height: 150,
              color: Colors.red.shade100,
              child: const Center(
                  child: Text('IMAGE NOT FOUND: Historical Image',
                      style: TextStyle(color: Colors.red))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHappyIslandSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              'Why The Happy Island?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryAccentColor),
            ),
          ],
        ),
        const Divider(height: 15),
        const Text(
          'Catanduanes, known as the Happy Island, is a place where natural beauty and the warm welcome of the Catandunganon people bring joy.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            'assets/happyisland.png',
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: double.infinity,
              height: 150,
              color: Colors.yellow.shade100,
              child: const Center(
                  child: Text('IMAGE NOT FOUND: Happy Island',
                      style: TextStyle(color: Colors.red))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryAccentColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: _currentImageUrl != null &&
                          _currentImageUrl!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            _currentImageUrl!,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person,
                                    color: primaryAccentColor, size: 40),
                          ),
                        )
                      : const Icon(Icons.person,
                          color: primaryAccentColor, size: 40),
                ),
                const SizedBox(height: 8),
                Text(
                  _currentUsername,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Role: ${widget.role}',
                  style:
                      const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Profile'),
            onTap: () {
              Navigator.pop(context);
              _navigateToEditProfile();
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('All Tourist Spots (API)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const PlaceholderTouristSpotListScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlaceholderLoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catanduanes Happy Island',
            style: TextStyle(color: Colors.white)),
        backgroundColor: primaryAccentColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $_currentUsername!',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryAccentColor),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Explore the Happy Island of Catanduanes!',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const Divider(height: 30, thickness: 1),
                ],
              ),
            ),

         
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildBriefHistorySection(),
            ),

       
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildHappyIslandSection(),
            ),

            const Divider(height: 40, thickness: 1),

        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildMunicipalitiesList(),
            ),

            const Divider(height: 40, thickness: 1),

      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildFeaturedSpotsGrid(),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}