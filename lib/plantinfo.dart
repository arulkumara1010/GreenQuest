import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      home: const RootPage(
        id: 1,
      ),
    );
  }
}

class Plant {
  final int id;
  final String commonName;
  final List<String> scientificName;
  final List<String> otherName;
  final String cycle;
  final String watering;
  final List<String> sunlight;
  final String imageUrl;
  final String description;
  final String care_level;
  final String dimension;

  Plant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.otherName,
    required this.cycle,
    required this.watering,
    required this.sunlight,
    required this.imageUrl,
    required this.description,
    required this.care_level,
    required this.dimension,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      commonName: json['common_name'] ?? 'Unknown Plant',
      scientificName: List<String>.from(json['scientific_name']),
      otherName: List<String>.from(json['other_name']),
      cycle: json['cycle'] ?? 'Unknown Cycle',
      watering: json['watering'] ?? 'Unknown Watering Info',
      sunlight: List<String>.from(json['sunlight']),
      imageUrl: json['default_image']['regular_url'] ?? '',
      description: json['description'] ?? 'Unknown Description',
      care_level: json['care_level'] ?? 'Unknown Care Level',
      dimension: json['dimension'] ?? 'Unknown Dimension',
    );
  }
}

class RootPage extends StatefulWidget {
  final int id;

  const RootPage({super.key, required this.id});

  @override
  State<RootPage> createState() => _RootPageState(id);
}

class _RootPageState extends State<RootPage> {
  final int id;

  _RootPageState(this.id);
  Plant? plant;
  bool isLoading = true;
  var counter = 0;

  Future<void> checkIfPlantIsSaved() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (userData.exists) {
          List<dynamic> savedPlants = userData['saved_plants'] ?? [];
          bool isPlantSaved = savedPlants.any((plant) => plant['id'] == id);
          setState(() {
            counter = isPlantSaved ? 1 : 0;
          });
        }
      }
    } catch (e) {
      print("Error checking if plant is saved: $e");
    }
  }

  String name = '';

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (userData.exists) {
          setState(() {
            name = userData['name'];
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlantData(id);
    fetchUserData();
    checkIfPlantIsSaved();
  }

  Future<void> fetchPlantData(int id) async {
    final url =
        'https://perenual.com/api/species/details/$id?key=sk-9q5S67e5b04671b269453';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        plant = Plant.fromJson(data);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load plant data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          plant?.imageUrl.isNotEmpty == true
              ? Image.network(
                  plant!.imageUrl,
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/image_1.jpeg',
                  width: screenWidth,
                  height: screenHeight * 0.4,
                  fit: BoxFit.cover,
                ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.35),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: screenHeight * 0.65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant?.commonName ?? 'Plant name',
                  style: const TextStyle(
                    fontSize: 30,
                    height: 3,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: screenHeight * 0.17,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Text(
                        'Description : ${plant?.description ?? 'Unknown'}',
                        style: GoogleFonts.inter(fontSize: 12),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Scientific Name: ${plant?.scientificName.join(', ')}\n'
                          'Other Names: ${plant?.otherName.join(', ')}\n'
                          'Cycle: ${plant?.cycle}\n'
                          'Watering: ${plant?.watering}\n'
                          'Sunlight: ${plant?.sunlight.join(', ')}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  )),
                ),
                const SizedBox(height: 7),
                const SizedBox(height: 7),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.45,
            left: 16,
            child: Row(
              children: [
                _buildTagContainer(
                    plant?.cycle ?? 'Unknown', '#F0F3F6', '#696969'),
                const SizedBox(width: 10),
                _buildTagContainer(
                    plant?.watering ?? 'Unknown', '#F0F3F6', '#696969'),
                const SizedBox(width: 10),
                _buildTagContainer(plant?.scientificName.first ?? 'Unknown',
                    '#F0F3F6', '#696969'),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.7,
            left: 16,
            child: Row(
              children: [
                _buildFeatureBox(
                    Icons.height,
                    'Height',
                    plant?.dimension.split(': ')[1] ?? 'N/A',
                    '#EEF7E8',
                    '#4B8364'),
                const SizedBox(width: 65),
                _buildFeatureBox(Icons.water_drop, 'Water',
                    plant?.watering ?? 'N/A', '#E6EAFA', '#5676DC'),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.8,
            left: 16,
            child: Row(
              children: [
                _buildFeatureBox(Icons.sunny, 'Light',
                    plant?.sunlight.first ?? 'N/A', '#FCF1E3', '#E6B44C'),
                const SizedBox(width: 65),
                _buildFeatureBox(Icons.eco, 'Care Level',
                    plant?.care_level ?? 'N/A', '#F8E8F8', '#A559D9'),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: screenWidth - 60,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: HexColor('#FFFFFF'),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.9,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  counter = counter == 0 ? 1 : 0;
                  if (counter == 1) {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null && plant != null) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .update({
                        'saved_plants': FieldValue.arrayUnion([
                          {'id': plant!.id, 'commonName': plant!.commonName}
                        ])
                      });
                    }
                  } else {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null && plant != null) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUser.uid)
                          .update({
                        'saved_plants': FieldValue.arrayRemove([
                          {'id': plant!.id, 'commonName': plant!.commonName}
                        ])
                      });
                    }
                  }
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(HexColor('#61AF2B')),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16)),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Spacer(),
                    Icon(
                      counter == 0 ? Icons.bookmark_border : Icons.bookmark,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      counter == 0 ? 'Grow this plant' : 'Remove plant',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTagContainer(String label, String bgColor, String textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: HexColor(bgColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: HexColor(textColor),
        ),
      ),
    );
  }

  Widget _buildFeatureBox(IconData icon, String label, String value,
      String bgColor, String iconColor) {
    return Container(
      width: 135,
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: HexColor(bgColor),
            ),
            child: Icon(
              icon,
              color: HexColor(iconColor),
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: HexColor(iconColor),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#333333'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
