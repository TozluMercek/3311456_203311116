import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmTextController = TextEditingController();

  void signUp() async {
    showDialog(
        context: context,
        builder: (context) => const CircularProgressIndicator());

    if (passwordTextController.text != confirmTextController.text) {
      Navigator.pop(context);
      displayMessage("Passwords don't match");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text
      );

      FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email!)
          .set({
        'username': emailTextController.text.split('@')[0],
        'bio': 'Empty bio..'
      });

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 50),
                AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Hadi Bir Hesap Oluşturalım',
                        textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        )
                    )
                  ],
                  repeatForever: true,
                ),
                const SizedBox(height: 25),
                MyTextField(
                    controller: emailTextController,
                    hintText: 'E-mail',
                    obsecureText: false),
                const SizedBox(height: 10),
                MyTextField(
                    controller: passwordTextController,
                    hintText: 'Password',
                    obsecureText: true),
                const SizedBox(height: 10),
                MyTextField(
                    controller: confirmTextController,
                    hintText: 'Confirm Password',
                    obsecureText: true),
                const SizedBox(height: 25),
                MyButton(onTap: signUp, text: 'Sign Up'),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
