import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_pg/book_page.dart';
import 'package:home_pg/cloth_donation.dart';
import 'package:home_pg/donatenow_page.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'profile_page.dart';
import 'signup.dart';
import 'blood_bank_page.dart';
import 'medicine_page.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';  // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    if (Firebase.apps.isNotEmpty) {
      print('Firebase initialized successfully');
    } else {
      print('Firebase initialization failed');
    }
  } catch (error) {
    print('Error initializing Firebase: $error');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error initializing Firebase: ${snapshot.error}');
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'NGO App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: StartPage(),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bgimage.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/SevaMedsLogo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'SevaMeds',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'On a Mission to Help the Helpless..',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _navigateToHomePage,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Text(
                            'Welcome to your App ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  // List of image file names for the slider
  List<String> imageFileNames = [
    'assets/images/c1.jpg',
    'assets/images/c2.jpg',
    'assets/images/c3.jpg',
    'assets/images/c4.jpg',
    // Add more image file names here
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/Blood_donate.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      // Other customization options can be added here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [], // Add children widgets if needed
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white, // Set background color
          ),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Hello',
                          style: TextStyle(
                            color: Color.fromARGB(255, 246, 193, 114),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          // Replace 'Jayesh' with the actual email of the user
                          DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc('Jayesh').get();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyProfilePage(userData: userDoc.data() as Map<String, dynamic>)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 219, 187, 84),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/bitmoji.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30), // Added SizedBox for spacing
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE9E4),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 35.0, left: 20.0),
                              child: Text(
                                'WE RISE BY',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 73, 72),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                'LIFTING OTHERS',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 73, 72),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 30),
                              child: TextButton(  // Changed ElevatedButton to TextButton
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MedicalPage(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(  // Changed ElevatedButton.styleFrom to TextButton.styleFrom
                                  backgroundColor: const Color(0xFFC7B8FB),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 0.0),
                                  child: Text(
                                    'Donate Now',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, right: 20.0),
                          child: GestureDetector(
                            onTap: () async {
                              // Fetch user data from Firestore
                              DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc('Jayesh').get();
                              // Navigate to MyProfilePage with user data
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyProfilePage(userData: userDoc.data() as Map<String, dynamic>)),
                              );
                            },
                            child: SizedBox(
                              width: 100,
                              height: 120,
                              child: Image.asset(
                                  'assets/images/donate_button.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30), // Added SizedBox for spacing
                  const Text(
                    'Causes',
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 73, 72),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20), // Added SizedBox for spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircularImageWithText('assets/images/bloodbank.png', 60, 'Blood Bank', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BloodBankPage()),
                        );
                      }),
                      _buildCircularImageWithText('assets/images/medi.png', 60, 'Medical Aid', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DonateMedicinePage()),
                        );
                      }),
                      _buildCircularImageWithText('assets/images/cloth.jpg', 60, 'Clothing', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClothDonationPage()),
                        );
                      }),
                      _buildCircularImageWithText('assets/images/book.jpeg', 60, 'Book Donate', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookPage()),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 30), // Added SizedBox for spacing
                  const Text(
                    'Need to Help First',
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 73, 72),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _controller.value.isInitialized
                      ? Container(
                          height: 200, // Adjust height as needed
                          child: Chewie(
                            controller: _chewieController,
                          ),
                        )
                      : Container(),
                  const SizedBox(height: 20), // Added SizedBox for spacing
                  const Text(
                    'Our Campaigns',
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 73, 72),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10), // Added SizedBox for spacing
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true, // Auto play enabled
                      autoPlayInterval: Duration(
                          seconds: 3), // Auto play interval set to 3 seconds
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                    items: imageFileNames.map((fileName) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image.asset(
                              fileName,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImageWithText(
      String imagePath, double size, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Image.asset(imagePath),
          ),
          const SizedBox(height: 5), // Adjust spacing between image and text
          Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 73, 73, 72),
              fontSize: 14, // Adjust font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}

// You can add MyProfilePage, BloodBankPage, and DonateMedicinePage classes here or import them from your files.
