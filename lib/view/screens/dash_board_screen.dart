import 'package:easy_mart/view/screens/cart_screen.dart';
import 'package:easy_mart/view/screens/favorite_screen.dart';
import 'package:easy_mart/view/screens/home_screen.dart';
import 'package:easy_mart/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],


      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.home_outlined, 0),
            navItem(Icons.shopping_cart_outlined, 1),
            navItem(Icons.favorite_border, 2),
            navItem(Icons.person_outline, 3),
          ],
        ),
      ),
    );
  }


  Widget navItem(IconData icon, int index) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 26,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
          const SizedBox(height: 6),
          Container(
            height: 7,
            width: isSelected ? 7 : 0,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
          )

        ],
      ),
    );
  }
}