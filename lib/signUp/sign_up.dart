import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:mobile_application/component/my_iconbutton.dart";
import "package:mobile_application/component/my_textbutton.dart";
import "package:mobile_application/component/my_button.dart";
import "package:mobile_application/component/my_textfield.dart";

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);

      if (e.code == 'invalid-email') {
        print('No user found for that email.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signInUser() async {
    if(fullnameController.text !="" && emailController.text !="" && passwordController.text != "" && cPasswordController.text != "") {
      print('Good job!');
    } else {
      print('Do not forget to input your name, email, and password!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Create your account!",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )
              ),
              const SizedBox(height: 10,),
              Text(
                "Let's start by putting your name, email, and password.",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                )
              ),
              const SizedBox(height: 20,),
              MyTextField(
                controller: fullnameController,
                hintText: 'Enter your name', 
                labelText: 'Fullname', 
                obscureText: false,
              ),
              const SizedBox(height: 20,),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email', 
                labelText: 'Email', 
                obscureText: false,
              ),
              const SizedBox(height: 20,),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password', 
                labelText: 'Password', 
                obscureText: true,
              ),
              const SizedBox(height: 20,),
              MyTextField(
                controller: cPasswordController,
                hintText: 'Confirm your password', 
                labelText: 'Confirm Password', 
                obscureText: true,
              ),
              const SizedBox(height: 25,),
              MyButton(onTap: createUserWithEmailAndPassword, hintText: 'sign Up'),
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(imagePath: 'assets/img/facebook_icon.png'),
                  SizedBox(width: 10),
                  MyIconButton(imagePath: 'assets/img/apple_icon.png'),
                ],
              ),

              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Already a member?', style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),),
                    const MyTextButton(labelText: 'Login now!', pageRoute: 'login',),
                  ],
                ),
              ),
              const Spacer(),
            ],
          )
        )
      ),
    );
  }
}