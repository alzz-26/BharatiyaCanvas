import 'dart:async';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BharatiyaCanvas());
}

class BharatiyaCanvas extends StatelessWidget {
  const BharatiyaCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BharatiyaCanvas',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'images/logo.jpeg',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              )
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Bharatiya Canvas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
          ],
        ),
      )
    );
  }
}