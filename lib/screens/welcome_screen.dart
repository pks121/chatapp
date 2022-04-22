import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "WelcomeScreen";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 1), upperBound: 36);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffb7de6e),
                Color(0xff2fe327),
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: controller.value,
                    child: Icon(
                      Icons.person,
                      size: controller.value,
                      color: Colors.pink[300],
                    ),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText('Welcome',
                        textStyle:
                            TextStyle(fontSize: 34, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 22),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Hero(
                    tag: "login",
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33),
                        color: const Color(0xff4081EC),
                      ),
                      padding: const EdgeInsets.only(
                          left: 84, top: 24, right: 85, bottom: 24),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      color: const Color(0xffFBB039),
                    ),
                    padding: const EdgeInsets.only(
                        left: 84, top: 24, right: 85, bottom: 24),
                    child: const Text("Signup"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
