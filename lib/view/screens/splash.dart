import 'package:flutter/material.dart';
import 'login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutBack,
        ));

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 👈 White background
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/splash_image.jpg",
                        width: 140,
                        height: 140,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "EasyMart",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
