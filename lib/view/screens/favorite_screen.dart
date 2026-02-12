import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
          "Favorites",
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

            // HEART ICON
            CircleAvatar(
              radius: width * 0.14,
              backgroundColor: Colors.pink.shade50,
              child: Icon(
                Icons.favorite_border,
                size: width * 0.16,
                color: Colors.pink,
              ),
            ),

            SizedBox(height: height * 0.02),


            Text(
              "No Favorites Yet",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: height * 0.01),

          ],
        ),
      ),
    );
  }
}