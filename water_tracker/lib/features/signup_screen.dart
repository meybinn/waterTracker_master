import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/set_up/SignUp.dart';

import 'package:water_tracker/features/setup_profile_screen.dart';
import 'package:water_tracker/intake_provider.dart';
import 'package:water_tracker/services/database_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String username = "";
  String email = "";
  String password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        username = _usernameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() async {
    if (_isEmailValid() != null ||
        _isPasswordValid() != null ||
        email.isEmpty ||
        username.isEmpty ||
        password.isEmpty) return;

    try {
      int userId =
          await DatabaseHelper.instance.insertUser(username, email, password);
      print("User added with Id: $userId");

      context.read<IntakeProvider>().setUsername(username);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SetupProfileScreen(),
        ),
      );
    } catch (e) {
      print("Error inserting user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error creating account. Try again!"),
        ),
      );
    }
  }

  void onClearTap() {
    setState(() {
      _passwordController.clear();
    });
  }

  String? _isPasswordValid() {
    if (password.isEmpty) return null;
    if (password.length < 8 || password.length > 20) {
      return "your password should be 9 to 20";
    }
    return null;
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign Up",
            style: GoogleFonts.sarabun(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v7,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Signup(
                      title: "Username",
                      hintText: "Input your name",
                      controller: _usernameController),
                  Gaps.v10,
                  Signup(
                    title: "Email",
                    hintText: "Input your email",
                    controller: _emailController,
                  ),
                  Gaps.v10,
                  Text(
                    "Password",
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v10,
                  TextField(
                    obscureText: _obscureText,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      filled: true, // 배경색 활성화
                      fillColor: Colors.white,
                      errorText: _isPasswordValid(),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xFFDFDCDC), width: 1.5),
                        gapPadding: Sizes.size2,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xFFDFDCDC), width: 1.5),
                        gapPadding: Sizes.size2,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xFFDFDCDC), width: 2),
                        gapPadding: Sizes.size2,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                        gapPadding: Sizes.size2,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xFFDFDCDC), width: 1.5),
                        gapPadding: Sizes.size2,
                      ),
                      hintText: "Input your password",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      hintStyle: GoogleFonts.scheherazadeNew(
                        fontSize: Sizes.size16,
                        color: Colors.grey,
                      ),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: onClearTap,
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: Colors.grey.shade500,
                              size: Sizes.size18,
                            ),
                          ),
                          Gaps.h8,
                          GestureDetector(
                            onTap: _toggleObscureText,
                            child: FaIcon(
                              _obscureText
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              color: Colors.grey.shade500,
                              size: Sizes.size18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gaps.v24,
                  GestureDetector(
                    onTap: _onNextTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Sizes.size6),
                      width: 660,
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.scheherazadeNew(
                          color: Color(0xFFE0E6FE),
                          fontSize: Sizes.size20 + Sizes.size2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
