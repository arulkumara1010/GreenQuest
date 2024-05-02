import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plantinfo.dart';
import 'saved.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Quest',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
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
                  onPressed: () {},
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
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Popular plants',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap on "View all" text here
                      },
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
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child : _buildPlantBox(
                    'assets/images/aloe_vera_14.png',
                    'Plant 1',
                  ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child : _buildPlantBox(
                    'assets/images/aloe_vera_12.png',
                    'Plant 2',
                  ),
                  ),
                  
                  
                  // Add more plant boxes here as needed
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 1.0,
                  width: 80.0,
                  color: Color(0xFFCBCACA),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 0, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Categories',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap on "View all" text here
                      },
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
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align vertically centered
                    children: [
                      Text(
                        'Icon Title',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description line 1',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align vertically centered
                    children: [
                      Text(
                        'Icon Title',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description line 1',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align vertically centered
                    children: [
                      Text(
                        'Icon Title',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description line 1',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align vertically centered
                    children: [
                      Text(
                        'Icon Title',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Description line 1',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 1.0,
                  width: 80.0,
                  color: Color(0xFFCBCACA),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 0, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Today\'s Alerts',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle tap on "View all" text here
                      },
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
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Icon Title',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Description line 1',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 20), // Right arrow
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Icon Title',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Description line 1',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 20), // Right arrow
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green
                          .withOpacity(0.1), // Adjust color as needed
                    ),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green, // Adjust color as needed
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Icon Title',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Description line 1',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 20), // Right arrow
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green, // Customize as needed
        unselectedItemColor: Colors.grey, // Customize as needed
        currentIndex: 0, // Set initial index as needed
        onTap: (index) {
          // Handle navigation to different screens based on index
          // For example:
          // if (index == 0) {
          //   // Navigate to Home screen
          // } else if (index == 1) {
          //   // Navigate to Search screen
          // } ... and so on
          if(index == 3)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage1()));
          }
        },
        selectedLabelStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700), // Custom font example
        unselectedLabelStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700), // Custom font example
      ),
    );
  }

  Widget _buildPlantBox(String imagePath, String plantName) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10), // Adjust margin as needed
      child: SizedBox(
        width: 186,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 24, 0, 9),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0x54D9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 55, 12, 30),
                  child: Text(
                    'Fits well',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Color(0xFF61AF2B),
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
                      color: Color(0xFF333333),
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
}
