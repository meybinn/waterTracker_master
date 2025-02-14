import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';

import 'package:water_tracker/features/setup_profile_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = "";
  String _email = "";
  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
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
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "Email not valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_isEmailValid() != null || _email.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetupProfileScreen(),
      ),
    );
    return;
  }

  void onClearTap() {
    _passwordController.clear();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
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
              fontSize: Sizes.size20,
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
                  Text(
                    "Username",
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v10,
                  SizedBox(
                    width: 600,
                    height: 37,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          gapPadding: Sizes.size2,
                        ),
                        hintText: "Input your name",
                        hintStyle: GoogleFonts.scheherazadeNew(
                          fontSize: Sizes.size16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "Email",
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v10,
                  SizedBox(
                    width: 600,
                    height: 37,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        errorText: _isEmailValid(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          gapPadding: Sizes.size2,
                        ),
                        hintText: "Input your email",
                        hintStyle: GoogleFonts.scheherazadeNew(
                          fontSize: Sizes.size16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "Password",
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v10,
                  SizedBox(
                    width: 600,
                    height: 37,
                    child: TextField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          gapPadding: Sizes.size2,
                        ),
                        hintText: "Input your password",
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
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Colors.grey.shade500,
                                size: Sizes.size18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.v24,
                  GestureDetector(
                    onTap: _onNextTap,
                    child: Container(
                      width: 660,
                      height: 37,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.scheherazadeNew(
                          color: Colors.white,
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
