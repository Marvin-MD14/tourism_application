import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// --- (Walang global const dito para maiwasan ang red lines) ---

class EditProfileScreen extends StatefulWidget {
  final String username;
  final String email;
  final String role;
  final String gender;
  final String country;
  final String? profileImageUrl; 

  const EditProfileScreen({
    super.key,
    required this.username,
    required this.email,
    required this.role,
    required this.gender,
    required this.country,
    this.profileImageUrl,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  
  // ⭐ INILIPAT DITO: Ginawang final field sa loob ng State class
  // Ito ang base URL ng iyong live server sa Hostinger
  final String _baseUrl = 'https://islanddigitalguide.com/catanduanes_api'; 
  
  // Endpoint URL na ginagamit ang base URL
  late final String _updateProfileUrl = '$_baseUrl/edit_profile.php';

  final TextEditingController _usernameController = TextEditingController();
  String? _selectedGender;
  String? _selectedCountry;
  File? _pickedImage;
  String? _currentImageUrl; 

  final List<String> genders = ['Male', 'Female'];
  final List<String> countries = ['Philippines', 
    'Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 
    'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 
    'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 
    'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 
    'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 
    'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 
    'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 
    'China', 'Colombia', 'Comoros', 'Congo (Brazzaville)', 'Congo (Kinshasa)', 
    'Costa Rica', 'Côte d\'Ivoire', 'Croatia', 'Cuba', 'Cyprus', 
    'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 
    'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 
    'Estonia', 'Eswatini', 'Ethiopia', 'Fiji', 'Finland', 
    'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 
    'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 
    'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras', 'Hong Kong',
    'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 
    'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 
    'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Kuwait', 
    'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 
    'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 
    'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 
    'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 
    'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 
    'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 
    'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 
    'Nigeria', 'North Korea', 'North Macedonia', 'Norway', 'Oman', 
    'Pakistan', 'Palau', 'Panama', 'Papua New Guinea', 'Paraguay', 
    'Peru', 'Poland', 'Portugal', 'Qatar', 'Romania', 
    'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 
    'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 
    'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 
    'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Korea', 
    'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 
    'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 
    'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 
    'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 
    'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom', 'United States', 
    'Uruguay', 'USA', // Dinagdag ang 'USA' for common use
    'Uzbekistan', 'Vanuatu', 'Venezuela', 'Vietnam', 
    'Yemen', 'Zambia', 'Zimbabwe'];

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    _selectedGender = widget.gender.isNotEmpty ? widget.gender : null;
    _selectedCountry = widget.country.isNotEmpty ? widget.country : null;
    _currentImageUrl = widget.profileImageUrl;
  }


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _currentImageUrl = null; 
      });
    }
  }


  Future<void> _saveChanges() async {
    if (_usernameController.text.isEmpty || _selectedGender == null || _selectedCountry == null) {
      _showErrorSnackbar('Please fill out all fields.');
      return;
    }

    try {
      final request = http.MultipartRequest('POST', Uri.parse(_updateProfileUrl));

      // I-submit ang form fields
      request.fields['email'] = widget.email;
      request.fields['username'] = _usernameController.text;
      request.fields['gender'] = _selectedGender!;
      request.fields['country'] = _selectedCountry!;

      // I-submit ang profile image (kung mayroon)
      if (_pickedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_image', 
            _pickedImage!.path,
            filename: 'profile_${widget.email.split('@')[0]}.jpg', 
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);

      if (jsonResponse['status'] == 'success') {
        _showSuccessSnackbar(jsonResponse['message']);
        
        // Kuhanin ang bagong image URL mula sa PHP response
        final String newImageUrl = jsonResponse['image_url'] ?? _currentImageUrl ?? '';

        // Ibalik ang data sa Home Screen
        if (mounted) {
          Navigator.pop(context, {
            'status': 'success',
            'newUsername': _usernameController.text,
            'newGender': _selectedGender,
            'newCountry': _selectedCountry,
            'newImageUrl': newImageUrl, 
          });
        }
      } else {
        _showErrorSnackbar(jsonResponse['message'] ?? 'Failed to update profile.');
      }
    } catch (e) {
      // Ipinapakita ang live server URL sa error message
      _showErrorSnackbar('Connection Error. Make sure your server is running at $_baseUrl. Error: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
      );
    }
  }

  void _showSuccessSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.lightBlue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
        
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.lightBlue,
                      child: ClipOval(
                        child: _pickedImage != null
                            ? Image.file(_pickedImage!, fit: BoxFit.cover, width: 120, height: 120) 
                            : (_currentImageUrl != null && _currentImageUrl!.isNotEmpty
                                ? Image.network( 
                                    _currentImageUrl!,
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.person, size: 60, color: Colors.white);
                                    },
                                  )
                                : const Icon(Icons.person, size: 60, color: Colors.white)), 
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, color: Colors.blue, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Role: ${widget.role} | Email: ${widget.email}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

          
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: _selectedGender,
              decoration: InputDecoration(
                labelText: 'Gender',
                prefixIcon: const Icon(Icons.people_alt),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: genders.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

        
            DropdownButtonFormField<String>(
              initialValue: _selectedCountry,
              decoration: InputDecoration(
                labelText: 'Country',
                prefixIcon: const Icon(Icons.flag),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: countries.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                _selectedCountry = newValue;
                });
              },
            ),
            const SizedBox(height: 40),

          
            ElevatedButton.icon(
              onPressed: _saveChanges,
              icon: const Icon(Icons.save),
              label: const Text('Save Changes', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            
          
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}