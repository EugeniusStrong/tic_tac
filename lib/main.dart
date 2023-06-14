import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about.dart';
import 'game_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartScreen(),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  static var startScreenWhiteFontStyle = GoogleFonts.schoolbell(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 45,
    ),
  );
  static var startScreenBlackFontStyle = GoogleFonts.schoolbell(
    textStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 50,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[900],
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(0.1),
              child: Text(
                'TIC TAC TOE',
                style: startScreenWhiteFontStyle,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              child: AvatarGlow(
                endRadius: 140,
                duration: const Duration(seconds: 2),
                glowColor: Colors.white,
                repeat: true,
                repeatPauseDuration: const Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.none),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    radius: 100.0,
                    child: Image.asset(
                      'assets/images/ttt.png',
                      color: Colors.white,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                alignment: Alignment.topCenter,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.white),
                    minimumSize: MaterialStatePropertyAll<Size>(
                      Size(320, 48),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameScreen()));
                  },
                  child: Text(
                    'Play Game',
                    style: startScreenBlackFontStyle,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutMe()));
              },
              child: Text(
                'created by Eugeniy',
                style: startScreenWhiteFontStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
