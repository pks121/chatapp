import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/registration_screen.dart';
import 'package:chatapp/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        '/chatScreen': (context) => const ChatScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        WelcomeScreen.id: (context) => const WelcomeScreen(),
      },
    ),
  );
}

class chatApp extends StatefulWidget {
  const chatApp({Key? key}) : super(key: key);

  @override
  State<chatApp> createState() => _chatAppState();
}

class _chatAppState extends State<chatApp> {
  final _auth = FirebaseAuth.instance;

  void getLoggedUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        Navigator.pushNamed(context, '/chatScreen');
      } else {
        print("login please");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      backgroundColor: Color(0xff1E3138),
    );
  }
}
