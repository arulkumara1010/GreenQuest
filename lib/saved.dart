import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'plantinfo.dart';
import 'myprofile.dart';

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white, // Subtle green background
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Saved',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_14.png',
                      'Plant 1',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_12.png',
                      'Plant 2',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_12.png',
                      'Plant 3',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_14.png',
                      'Plant 4',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_12.png',
                      'Plant 5',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RootPage()));
                    },
                    child: _buildPlantBox(
                      'assets/images/aloe_vera_14.png',
                      'Plant 6',
                    ),
                  ),
                ],
              ),
            ),
          ],
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
        currentIndex: 3, // Set initial index as needed
        onTap: (index) {
          // Handle navigation to different screens based on index
          // For example:
          // if (index == 0) {
          //   // Navigate to Home screen
          // } else if (index == 1) {
          //   // Navigate to Search screen
          // } ... and so on
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountPage()));
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

  Widget buildPlantCard(String plantName, String description, String imagePath,
      BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PlantDetailPage(plantName, description, imagePath)),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                    imagePath), // Use NetworkImage for external URLs
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Text(
              plantName,
              style: TextStyle(color: Colors.white, fontSize: 18.0, shadows: [
                Shadow(blurRadius: 3.0, color: Colors.black.withOpacity(0.5))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class PlantDetailPage extends StatelessWidget {
  final String plantName;
  final String description;
  final String imagePath;

  PlantDetailPage(this.plantName, this.description, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 200.0, height: 200.0),
            Text(description, style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Quest',
      home: HomePage1(),
    );
  }
}
