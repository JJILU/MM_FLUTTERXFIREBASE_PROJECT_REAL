// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_app/features/auth/widgets/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_app/features/auth/widgets/my_textfield.dart';
import 'package:firebase_app/features/auth/widgets/my_button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  // password editing controllers
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    BuildContext? dialogContext;

    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      // try sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //  pop the loading circle, if login is successfull
      if (dialogContext != null) {
        Navigator.pop(dialogContext!);
      }
    } on FirebaseAuthException catch (e) {
      //  pop the loading circle, if login failed
      if (dialogContext != null) {
        Navigator.pop(dialogContext!);
      }

      String msg = "";
      print("Firebase error code: ${e.code}");

      if (e.code == "invalid-email") {
        msg = "invalid email";
      } else if (e.code == "invalid-credential") {
        msg = "Invalid email or password.";
      } else {
        msg = "An error occured. Code ${e.code}";
      }

      // show alert error dialog
      //   await showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: const Text("Login Failed"),
      //       content: Text(msg),
      //       actions: [
      //         TextButton(onPressed: () {
      //           Navigator.pop(context);
      //         }, child:  Text("Ok"),),
      //       ],
      //     ),
      //   );
      // }

      // show error message
      showErrorMessage(msg);
    }
  }

  void showErrorMessage(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Failed"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                //  welcome back, you've been missed!
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // username textfeild
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                // password textfeild
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "forgot password",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button
                MyButton(
                  buttonText: "Sign In",
                  buttonBgColor: Colors.black,
                  buttonTextColor: Colors.white,
                  onTap: signUserIn,
                ),

                const SizedBox(
                  height: 50,
                ),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                        imagePath: "lib/images/google.png", onTap: () {}),

                    const SizedBox(
                      width: 10,
                    ),

                    // apple button
                    SquareTile(imagePath: "lib/images/apple.png", onTap: () {}),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
