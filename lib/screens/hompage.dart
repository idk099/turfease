import 'package:flutter/material.dart';
import 'package:Turfease/Authentication/Services/authenticationservice.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Authenticate _auth = Authenticate();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _auth.siginOut();
              },
              icon: Icon(Icons.exit_to_app_sharp))
        ],
        title: Text(
          'Homepage',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("hello,welcome"),
      ),
    );
  }
}
