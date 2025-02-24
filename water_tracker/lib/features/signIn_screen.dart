import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/main_navigation/main_navigation_screen.dart';
import 'package:water_tracker/features/set_up/SignUp.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String email = "";
  String password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    if (email.isEmpty || password.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(tab: 'home'),
      ),
    );
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

  String? _isPasswordValid() {
    if (password.isEmpty) return null;
    if (password.length < 9 || password.length > 20) {
      return "your password should be 8 to 20";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  void onClearTap() {
    setState(() {
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign in",
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
                  Text(
                    "Email",
                    style: GoogleFonts.scheherazadeNew(
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v10,
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true, // 배경색 활성화
                      fillColor: Colors.white,
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xFFDFDCDC), width: 1.5),
                        gapPadding: Sizes.size2,
                      ),
                      hintText: "Input your email",
                      errorText: _isEmailValid(),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      hintStyle: GoogleFonts.scheherazadeNew(
                        fontSize: Sizes.size16,
                        color: Colors.grey,
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
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
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
                        "Sign in",
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
