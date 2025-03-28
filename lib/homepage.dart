import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plantinfo.dart';
import 'plantinfoopy.dart';
import 'saved.dart';
import 'myprofile.dart';
import 'rewards.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'search_page.dart';
import 'package:http/http.dart' as http;

class PlantIdentificationScreen extends StatefulWidget {
  const PlantIdentificationScreen({Key? key}) : super(key: key);

  @override
  _PlantIdentificationScreenState createState() =>
      _PlantIdentificationScreenState();
}

class _PlantIdentificationScreenState extends State<PlantIdentificationScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _takePicture() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        await _identifyPlant();
      }
    } catch (e) {
      print('Error taking picture: $e');
      _showErrorSnackBar('Failed to take picture: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        await _identifyPlant();
      }
    } catch (e) {
      print('Error picking image: $e');
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _identifyPlant() async {
    if (_imageFile == null) {
      _showErrorSnackBar('No image selected');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://my-api.plantnet.org/v2/identify/all?api-key=2b10AAFEh22qI1Dq0IWaNgdxWe'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('images', _imageFile!.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        String bestMatch = jsonResponse['bestMatch'] ?? 'Unknown';
        var results = jsonResponse['results'];
        if (results != null && results.isNotEmpty) {
          var topResult = results[0];
          String scientificName =
              topResult['species']['scientificName'] ?? 'Unknown';
          double score = topResult['score'] ?? 0.0;
          await _showResultDialog(scientificName, score, bestMatch);
        } else {
          _showErrorSnackBar('No results found');
        }
      } else {
        _showErrorSnackBar(
            'Failed to identify plant. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorSnackBar('Error identifying plant: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _showResultDialog(
      String scientificName, double score, String bestMatch) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Plant Identification Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.file(_imageFile!),
                const SizedBox(height: 10),
                Text('Scientific Name: $scientificName'),
                Text('Confidence Score: ${(score * 100).toStringAsFixed(2)}%'),
                Text('Best Match: $bestMatch'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Identification'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _takePicture,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take a Picture'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      textStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _pickFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Choose from Gallery'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      textStyle: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_imageFile != null)
                    Image.file(
                      _imageFile!,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    )
                  else
                    Text(
                      'No image selected',
                      style: GoogleFonts.dmSans(),
                    ),
                ],
              ),
      ),
    );
  }
}

class Alert {
  final String title;
  final String description;
  final String type; // e.g., 'care', 'weather', 'health', 'achievement'
  final DateTime timestamp;

  Alert({
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
  });
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Text(
                    'Green Quest',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 5.4, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Plants',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage(
                                          initialQuery: '',
                                        )));
                          },
                          icon: const Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.add_circled,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PlantIdentificationScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: const Size(200.0, 50.0),
                    backgroundColor: const Color(0xFFEEF7E8),
                  ),
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                  ),
                  label: Text(
                    'Scan and Identify the Plant',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              _buildSection('Popular plants', () {
                // Handle tap on "View all" text here
              }),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootPage(
                                    id: 1,
                                  )));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_14.png',
                      'Silver Fir',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RootPage(
                                    id: 2,
                                  )));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_12.png',
                      'Pyramidalis',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 1.0,
                  width: 80.0,
                  color: const Color(0xFFCBCACA),
                ),
              ),
              _buildSection('Categories', () {
                // Handle tap on "View all" text here
              }),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            initialQuery: 'Rose',
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryItem(
                        Icons.eco, 'Rose', 'A flower of love   '),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            initialQuery: 'Cactus',
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryItem(
                        Icons.eco, 'Cactus', 'A poky desert plant'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            initialQuery: 'Fir',
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryItem(
                        Icons.eco, 'Fir', 'A tall green tree  '),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(
                            initialQuery: 'Palm',
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryItem(
                        Icons.eco, 'Palm', 'A tropical tree         '),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 1.0,
                  width: 80.0,
                  color: const Color(0xFFCBCACA),
                ),
              ),
              _buildSection('Today\'s Alerts', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlertsPage(alerts: _mockAlerts),
                  ),
                );
              }),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: _mockAlerts.length,
                  itemBuilder: (context, index) {
                    Alert alert = _mockAlerts[index];
                    return _buildAlertItem(alert);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.green,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'My Plants',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchPage(
                          initialQuery: '',
                        )),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Rewards()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage1()),
              );
            } else if (index == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccountPage()),
              );
            }
          },
          selectedLabelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildSection(String title, VoidCallback onViewAllTap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 0, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: const Color(0xFF333333),
              ),
            ),
          ),
          GestureDetector(
            onTap: onViewAllTap,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 6, 20, 1),
              child: Text(
                'View all',
                textAlign: TextAlign.right,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: const Color(0xFF61AF2B),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantBox(String imagePath, String plantName) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: SizedBox(
        width: 186,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 24, 0, 9),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0x54D9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 55, 12, 30),
                  child: Text(
                    'Fits well',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: const Color(0xFF61AF2B),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                bottom: 0,
                child: SizedBox(
                  height: 63,
                  child: Text(
                    plantName,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xFF333333),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -20,
                top: -20,
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(imagePath),
                      ),
                    ),
                    width: 144,
                    height: 144,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title, String description) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.green.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Alert alert) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getAlertIcon(alert.type),
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.description,
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case 'care':
        return Icons.water_drop;
      case 'weather':
        return Icons.cloud;
      case 'health':
        return Icons.warning;
      case 'achievement':
        return Icons.star;
      default:
        return Icons.info;
    }
  }

  List<Alert> _mockAlerts = [
    Alert(
      title: 'Water Your Plants',
      description: 'Your plants need watering today.',
      type: 'care',
      timestamp: DateTime.now(),
    ),
    Alert(
      title: 'Rain Expected Tomorrow',
      description: 'Heavy rain expected. Protect your outdoor plants.',
      type: 'weather',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ];
}

class AlertsPage extends StatefulWidget {
  final List<Alert> alerts;

  const AlertsPage({Key? key, required this.alerts}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late List<Alert> alerts;

  @override
  void initState() {
    super.initState();
    alerts = widget.alerts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Alerts'),
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          Alert alert = alerts[index];
          return _buildAlertItem(alert);
        },
      ),
    );
  }

  Widget _buildAlertItem(Alert alert) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getAlertIcon(alert.type),
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Complete Button
          ElevatedButton(
            onPressed: () {
              // Increase the rewards count for the user
              _increaseUserRewards();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Complete',
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAlertIcon(String type) {
    switch (type) {
      case 'care':
        return Icons.water_drop;
      case 'weather':
        return Icons.cloud;
      case 'health':
        return Icons.warning;
      case 'achievement':
        return Icons.star;
      default:
        return Icons.info;
    }
  }
}

void _increaseUserRewards() async {
  try {
    // Replace 'users' with your Firestore collection name
    // Replace 'userId' with the actual user ID (e.g., from FirebaseAuth)
    User? currentUser =
        FirebaseAuth.instance.currentUser; // Replace with the actual user ID
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);

    // Fetch the current reward tokens
    DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      int currentRewards = userSnapshot['rewardTokens'] ?? 0;
      print(currentRewards);
      // Increment the reward tokens
      int randomReward = (1 +
          (49 * (new DateTime.now().millisecondsSinceEpoch % 1000) / 1000)
              .floor());
      await userDoc.update({'rewardTokens': currentRewards + randomReward});
      print('Reward tokens updated successfully!');
    } else {
      print('User document does not exist.');
    }
  } catch (e) {
    print('Error updating reward tokens: $e');
  }
}
