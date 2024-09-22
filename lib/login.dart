import 'package:flutter/material.dart';
import 'forgot_password.dart';
import 'service/auth.dart';
import 'signup.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "";
  String password = "";

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Status"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Inside the userLogin() function in LogIn widget
  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // Retrieve user data from Firestore based on logged-in user's email
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
      // Pass user data to MyProfilePage
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
      showAlertDialog("Login Successful");
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
    } catch (e) {
      // Handle general exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 18.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFedf0f8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 18.0),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = mailController.text;
                            password = passwordController.text;
                          });
                        }
                        userLogin();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF273671),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Color(0xFF8c8e98),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "or LogIn with",
              style: TextStyle(
                color: Color(0xFF273671),
                fontSize: 22.0,
                fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Image.asset(
                    "assets/images/google.png",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 30.0,
                ),
              ],
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Color(0xFF8c8e98),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      color: Color(0xFF273671),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
