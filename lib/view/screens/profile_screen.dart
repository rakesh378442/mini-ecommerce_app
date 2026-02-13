import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: width * 0.14,
              backgroundColor: Colors.orange.shade100,
              child: Icon(
                Icons.person,
                size: width * 0.16,
                color: Colors.orange,
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              "Rakesh Kumar",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}