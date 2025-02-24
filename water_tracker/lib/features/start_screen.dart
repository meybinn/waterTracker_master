import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:water_tracker/constant/gaps.dart';
import 'package:water_tracker/constant/sizes.dart';
import 'package:water_tracker/features/signIn_screen.dart';
import 'package:water_tracker/features/signup_screen.dart';
import 'package:water_tracker/intake_provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    final intakeProvider = Provider.of<IntakeProvider>(context, listen: false);
    intakeProvider.loadUserData(" ");
  }

  void _onSignUpTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupScreen(),
      ),
    );
  }

  void _onSignInTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SigninScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: Stack(
          children: [
            Positioned(
              left: 35,
              right: 25,
              top: 20,
              bottom: 156,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Drink",
                    style: GoogleFonts.righteous(
                      color: Color(0xFF7C7C7C),
                      fontSize: Sizes.size60 + Sizes.size4,
                    ),
                  ),
                  Text(
                    "Up!",
                    style: GoogleFonts.righteous(
                      color: Color(0xFF7C7C7C),
                      fontSize: Sizes.size60 + Sizes.size4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 110),
                    child: Image.asset(
                      'assets/icons/arcticons_waterdrinkreminder.png',
                      width: 177,
                      height: 177,
                    ),
                  ),
                  Gaps.v10,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      '"Get daily reminders tracks, reminder your progress, and stay on top of your hydration goals."',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF7C7C7C),
                        fontSize: Sizes.size14 + Sizes.size1,
                      ),
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: _onSignUpTap,
                    child: Container(
                      width: 177,
                      height: 52,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.righteous(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: _onSignInTap,
                    child: Container(
                      width: 177,
                      height: 52,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.righteous(
                          color: Colors.white,
                          fontSize: Sizes.size20,
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
