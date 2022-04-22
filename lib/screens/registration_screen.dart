import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  String mobile = "";
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _saving,
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
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.pink),
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
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  style: const TextStyle(color: Colors.pink),
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
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value == password && value != "") {
                        password = value;
                      } else {
                        print("Wrong Password ReEntered");
                      }
                    },
                    obscureText: true,
                    style: const TextStyle(color: Colors.pink),
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
                      hintText: "ReEnter Password",
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      mobile = value;
                    },
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.pink),
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
                      hintText: "Enter Mobile Number",
                      icon: Icon(Icons.phone),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
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
                        _saving = true;
                      });

                      try {
                        UserCredential user =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(context, '/chatScreen');
                          setState(() {
                            _saving = false;
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                      // print(userName + Password + mobile);
                      // try {
                      //   final newUser =
                      //       await _auth.createUserWithEmailAndPassword(
                      //           email: email, password: password);
                      //   if (newUser != null) {
                      //     Navigator.pushNamed(context, '/chatScreen');
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }
                    },
                    child: const Text(
                      "Register",
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
                          "SignUp with Google",
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
