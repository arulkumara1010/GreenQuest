import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/image_1.jpeg'),
          Container(
            margin: const EdgeInsets.only(top: 230),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 900,
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
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam posuere nisi diam, congue pharetra mauris eleifend vitae. Nulla fermentum a massa non condimentum. Vestibulum lacus dui, tristique eu mattis ut, dignissim eget urna. Duis imperdiet nisi vel',
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
              top: 315,
              left: 16,
              child: Row(
                children: [
                  Container(
                    width: 69,
                    height: 24,
                    decoration: BoxDecoration(
                      color: HexColor('#F0F3F6'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Indoor',
                        style: TextStyle(
                          fontSize: 12,
                          color: HexColor('#696969'),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 97,
                    height: 24,
                    decoration: BoxDecoration(
                      color: HexColor('#F0F3F6'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Pet Friendly',
                        style: TextStyle(
                          fontSize: 12,
                          color: HexColor('#696969'),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 89,
                    height: 24,
                    decoration: BoxDecoration(
                      color: HexColor('#F0F3F6'),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Malvaceae',
                        style: TextStyle(
                          fontSize: 12,
                          color: HexColor('#696969'),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: 545,
            left: 16,
            child: Row(
              children: [
                Container(
                  width: 134,
                  height: 58,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#EEF7E8')),
                        child: Icon(
                          Icons.height,
                          color: HexColor('#4B8364'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                          width: 64,
                          height: 47,
                          margin: const EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Text(
                                'Height',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#4B8364')),
                              ),
                              Text('Small',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#333333')))
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(width: 65),
                Container(
                  width: 135,
                  height: 58,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#E6EAFA')),
                        child: Icon(
                          Icons.water_drop,
                          color: HexColor('#5676DC'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                          width: 64,
                          height: 47,
                          margin: const EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Text(
                                'Water',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#7C95E4')),
                              ),
                              Text('300ml',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#333333')))
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 620,
            left: 16,
            child: Row(
              children: [
                Container(
                  width: 134,
                  height: 58,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#FCF1E3')),
                        child: Icon(
                          Icons.sunny,
                          color: HexColor('#E6B44C'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                          width: 64,
                          height: 47,
                          margin: const EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Text(
                                'Light',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#EAC069')),
                              ),
                              Text('Normal',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#333333')))
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(width: 65),
                Container(
                  width: 135,
                  height: 58,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#F8E8F8')),
                        child: Icon(
                          Icons.thermostat,
                          color: HexColor('#A559D9'),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                          width: 64,
                          height: 47,
                          margin: const EdgeInsets.only(top: 6),
                          child: Column(
                            children: [
                              Text(
                                'Humidity',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#C390E6')),
                              ),
                              Text('55%',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#333333')))
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 30,
              left: 320,
              right: 16,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomePage())); 
                   
                  },
                  child: Icon(
                    Icons.close,
                    color: HexColor('#FFFFFF'),
                  ))),
          Positioned(
            top: 700,
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
                  padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                ),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 85),
                      Icon(
                        counter == 0 ? Icons.bookmark_border : Icons.bookmark,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        counter == 0 ? 'Save this plant' : 'Unsave plant',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 85),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
