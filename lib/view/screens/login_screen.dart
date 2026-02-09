import 'package:easy_mart/view/screens/dash_board_screen.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppConstColors.lightBlue,
              AppConstColors.lightBlue,
              AppConstColors.lightBlue,
              AppConstColors.slowOrange,
              AppConstColors.slowOrange1,
              AppConstColors.lightBlue
            ],
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.08,
              vertical: size.height * 0.1,
            ),

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  const Center(
                    child: Text(
                      "Hello Again!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Center(
                    child: Text(
                      "Welcome back you've \n been missed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),


                  _inputField(
                    hint: "Enter Email",
                    icon: Icons.email_outlined,
                    keybardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email required";
                      }

                      if (!RegExp(
                          r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return "Enter valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),


                  _inputField(
                    hint: "Enter Password",
                    icon: Icons.lock_outline,
                    keybardType: TextInputType.text,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password required";
                      }

                      if (value.length < 6) {
                        return "Password minimum 6 characters hona chahiye";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Recovery Password",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8C42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashBoardScreen(),


                            ),

                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signin Successful")));
                        }
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.black)),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Text(
                          "or continue with",
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: const [
                      Expanded(
                        child: _SocialButton(
                          image: "assets/images/google_icon.png",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          image: "assets/images/apple_icon.png",
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _SocialButton(
                          image: "assets/images/facebook_icon.png",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member? "),
                      Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required IconData icon,
    required TextInputType keybardType,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      keyboardType: keybardType,
      obscureText: isPassword ? hidePassword : false,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            hidePassword
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}


class _SocialButton extends StatelessWidget {

  final String image;

  const _SocialButton({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Image.asset(
          image,
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
