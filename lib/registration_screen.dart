import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// UPDATED: Gamit na ang live domain URL para sa registration
const String apiUrl = "https://islanddigitalguide.com/catanduanes_api/register.php";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  String? _selectedCountry;
  bool _isLoading = false;

  final List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];
  final List<String> _countries = ['Philippines', 
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

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showSnackBar('Error: Passwords do not match!');
        return;
      }

      if (_selectedGender == null || _selectedCountry == null) {
        _showSnackBar('Error: Please select Gender and Country.', isError: true);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      _showSnackBar('Registering user...');

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'username': _usernameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'gender': _selectedGender!,
            'country': _selectedCountry!,
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data['status'] == 'success') {
            _showSnackBar('SUCCESS: ${data['message']}');
            Navigator.pop(context);
          } else {
            _showSnackBar('Registration Failed: ${data['message']}', isError: true);
          }
        } else {
          _showSnackBar('Server Connection Error! Status: ${response.statusCode}', isError: true);
        }
      } catch (e) {
        // UPDATED ERROR MESSAGE: Gumagamit na ng live URL.
        _showSnackBar('Connection Error: Make sure your API is accessible at $apiUrl. Error: ${e.toString()}', isError: true);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showSnackBar('Please fill up all required fields correctly.', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your Account', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            
            Column(
              children: [
                Image.asset(
                  'assets/happyisland.png',
                  height: 130,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 2),
                Text(
                  'Join Island Digital Guide!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create your account to start exploring Catanduanes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 25),
              ],
            ),

        
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildTextFormField(
                    context,
                    controller: _usernameController,
                    label: 'Username',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Username is required.' : null,
                  ),
                  _buildTextFormField(
                    context,
                    controller: _emailController,
                    label: 'Email Address',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required.';
                      } else if (!value.contains('@')) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    context,
                    controller: _passwordController,
                    label: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required.';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  _buildTextFormField(
                    context,
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password is required.';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  _buildDropdownButton(
                    'Select Gender',
                    _selectedGender,
                    _genders,
                    (String? newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 15),

                  _buildDropdownButton(
                    'Select Country',
                    _selectedCountry,
                    _countries,
                    (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownButton(
    String hint,
    String? selectedValue,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: selectedValue,
          isExpanded: true,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}