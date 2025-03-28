import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_quest/search_page.dart';
import 'homepage.dart';
import 'saved.dart';
import 'myprofile.dart';
import 'search_page.dart';
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
      title: 'Green Quest',
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
      ),
      home: const Rewards(),
    );
  }
}

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  RewardsState createState() => RewardsState();
}

class RewardsState extends State<Rewards> {

  int rewardPoints = 0;

  Future<void> fetchUserData() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    DocumentReference userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid);

    DocumentSnapshot userData = await userDoc.get();

    if (userData.exists) {
      if (mounted) {
        setState(() {
          rewardPoints = userData['rewardPoints'];
        });
      }
    } 
  }
}

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }


  int showRewards = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set container background color to red
      child: Scaffold(
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
                          // Change this to the desired color
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 120), // Add some space between elements
                // Stack to overlay image, icon, and text
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300, // Adjust box height as needed
                      decoration: BoxDecoration(
                        color: const Color(0x54D9D9D9),
                        // Change box color as needed
                        borderRadius: BorderRadius.circular(
                            250), // Adjust border radius as needed
                      ),
                    ),
                    Column(
                      children: [
                        // Add the leaf icon
                        const Icon(
                          Icons.energy_savings_leaf,
                          size: 25, // Adjust icon size as needed
                          color: Colors.green, // Change icon color as needed
                        ),
                        const SizedBox(
                            height: 10), // Add some space between elements
                        // Add the small text below the leaf icon
                        const Text(
                          'Eco Tokens',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // Add some space between elements
                        // Add the big text below the small text
                        Text(
                          rewardPoints.toString(),
                          style: GoogleFonts.dmSans(
                              fontSize: 100, fontWeight: FontWeight.bold),
                        ), // Add some space between elements
                        // Add the button below the big text
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showRewards = 1; // Update the value of showRewards
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            minimumSize: const Size(200.0, 50.0),
                            backgroundColor: Colors.green,
                          ),
                          child: Text('See Rewards',
                              style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),


                
                
                if (showRewards == 1) ...[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Get Rewarded',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.bold,
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
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("₹50 Cashback", 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("300 Tokens", 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Win up to ₹500", 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("200 Tokens", 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("₹100 Play Credits", 
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                                Text("500 Tokens", 
                                    style: TextStyle(fontSize: 14, color: Colors.white)),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ],
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // Modify the colors as needed
            canvasColor: Colors.white, // Background color
            primaryColor: Colors.green, // Active item color
            textTheme: Theme.of(context).textTheme.copyWith(),
          ),
          child: BottomNavigationBar(
            // Set other properties of the BottomNavigationBar as needed
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
            selectedItemColor: Colors.green,
            // Customize as needed
            unselectedItemColor: Colors.grey,
            // Customize as needed
            currentIndex: 2,
            // Set initial index as needed
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
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
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
            // Custom font example
            unselectedLabelStyle: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700), // Custom font example
          ),
        ),
      ),
    );
  }
}
