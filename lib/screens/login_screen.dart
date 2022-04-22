import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffb7de6e),
                Color(0xff2fe327),
              ],
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "logo",
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 66,
                        child: Icon(
                          Icons.person,
                          size: 76,
                          color: Colors.pink[300],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      "CHAT APP",
                      style: TextStyle(fontSize: 34, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Color(0xff32a006)),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      constraints: BoxConstraints(maxWidth: 341),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0x0fff0000),
                            width: 12,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      // labelText: 'User',
                      hintText: "Enter Email",
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(color: Color(0xff32a006)),
                  obscureText: true,
                  decoration: const InputDecoration(
                    focusColor: Colors.pinkAccent,
                    filled: true,
                    constraints: BoxConstraints(maxWidth: 341),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    hintText: "Enter Password",
                    icon: Icon(Icons.remove_red_eye),
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Hero(
                  tag: "login",
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(33))),
                    padding: const EdgeInsets.only(
                        left: 45, right: 45, top: 18, bottom: 18),
                    color: const Color(0xff4081EC),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        UserCredential userCredential =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.pushNamed(context, '/chatScreen');
                        setState(() {
                          showSpinner = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  "OR",
                  style: TextStyle(fontSize: 44, color: Colors.white30),
                ),
                const SizedBox(height: 9),
                MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(33))),
                  padding: const EdgeInsets.only(
                      left: 45, right: 45, top: 18, bottom: 18),
                  color: const Color(0xff4081EC),
                  onPressed: () {},
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "lib/images/google.png",
                            width: 22,
                            height: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Sign in with Google",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
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
