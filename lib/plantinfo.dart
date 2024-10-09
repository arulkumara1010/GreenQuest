import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  var counter = 1;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/image_1.jpeg',
            width: screenWidth,
            height: screenHeight * 0.4, // Adjust image height dynamically
            fit: BoxFit.cover, // Cover the screen width properly
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plant name',
                  style: TextStyle(
                    fontSize: 30,
                    height: 3,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 7),
                Text(
                  'From Wikipedia, the free encyclopedia',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 7),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere nisi diam, congue pharetra mauris eleifend vitae...',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w200),
                ),
                Text(
                  'Read more..',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.45, // Adjusted position based on screen height
            left: 16,
            child: Row(
              children: [
                _buildTagContainer('Indoor', '#F0F3F6', '#696969'),
                const SizedBox(width: 10),
                _buildTagContainer('Pet Friendly', '#F0F3F6', '#696969'),
                const SizedBox(width: 10),
                _buildTagContainer('Malvaceae', '#F0F3F6', '#696969'),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.7, // Adjusted based on screen height
            left: 16,
            child: Row(
              children: [
                _buildFeatureBox(
                    Icons.height, 'Height', 'Small', '#EEF7E8', '#4B8364'),
                const SizedBox(width: 65),
                _buildFeatureBox(Icons.water_drop, 'Water', '300ml',
                    '#E6EAFA', '#5676DC'),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.8, // Adjusted position
            left: 16,
            child: Row(
              children: [
                _buildFeatureBox(
                    Icons.sunny, 'Light', 'Normal', '#FCF1E3', '#E6B44C'),
                const SizedBox(width: 65),
                _buildFeatureBox(Icons.thermostat, 'Humidity', '55%',
                    '#F8E8F8', '#A559D9'),
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
            top: screenHeight * 0.9, // Adjusted button position
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  counter = counter == 0 ? 1 : 0;
                });
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(HexColor('#61AF2B')),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16)),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Spacer(), // Add space to center the content
                    Icon(
                      counter == 0 ? Icons.bookmark_border : Icons.bookmark,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      counter == 0 ? 'Save this plant' : 'Unsave plant',
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
