import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:mobile_application/component/my_iconbutton.dart";
import "package:mobile_application/component/my_textbutton.dart";
import "package:mobile_application/component/my_button.dart";
import "package:mobile_application/component/my_textfield.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

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

      _showMyDialog1('Create successfully.');

    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);

      if (e.code == 'weak-password') {
        _showMyDialog1('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showMyDialog2('There is already a user in the firebase.');
      }
    }
  }

  void _showMyDialog1(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('AlertDialog Title'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMyDialog2(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('AlertDialog Title'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop('login');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
