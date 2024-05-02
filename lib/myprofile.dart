import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'plantinfo.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: MyAccountPage(),
  ));
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/736x/c7/5d/82/c75d82a1b2bd01c7d7cdbd19ff6b9f79.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  int treesPlanted = 0;
  int plantsPlanted = 0;
  String name = 'John Doe';
  String email = 'john.doe@example.com';
  String address = '123 Green Street, City, Country';
  String phone = '+123 456 7890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'My Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 45, 189, 89),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-man-laughing_23-2148859448.jpg?size=338&ext=jpg&ga=GA1.1.1224184972.1714521600&semt=ais'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      email,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      address,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      phone,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Plants Grown',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '$plantsPlanted',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlantGallery()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade300),
                      ),
                      child: Text(
                        'View plants grown',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          plantsPlanted++;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade300),
                      ),
                      child: Text(
                        'Grow a Plant',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                    name: name,
                                    email: email,
                                    address: address,
                                    phone: phone,
                                  )),
                        ).then((result) {
                          if (result != null && result is Map<String, String>) {
                            setState(() {
                              // Update profile details if edited
                              name = result['name']!;
                              email = result['email']!;
                              address = result['address']!;
                              phone = result['phone']!;
                            });
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green.shade300),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.green.shade300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class PlantGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Gallery'),
      ),
      body: Stack(
        children: [
          BackgroundImage(),
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(4, (index) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RootPage()));
                  },
                  child: _buildPlantBox(
                    'assets/images/aloe_vera_14.png',
                    'Plant 1',
                  ),
                ),
              );
            }),
          ),
        ],
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

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String address;
  final String phone;

  EditProfilePage({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user information
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _addressController = TextEditingController(text: widget.address);
    _phoneController = TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Stack(
        children: [
          BackgroundImage(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'address': _addressController.text,
                      'phone': _phoneController.text,
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
