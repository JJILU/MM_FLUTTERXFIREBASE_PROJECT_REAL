import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get current user
  final user = FirebaseAuth.instance.currentUser;

  void printUserDetails() {
    print(user!.metadata);
    print(user!.uid);
    
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),

          IconButton(
            onPressed: printUserDetails,
            icon: Icon(Icons.book),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Logged In as: ${user!.email}",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
