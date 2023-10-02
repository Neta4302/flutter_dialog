import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:mobile_application/signUp/sign_up.dart";
import "package:mobile_application/signIn/sign_in.dart";

class MyTextButton extends StatelessWidget {
  const MyTextButton(
    {
      super.key, 
      required this.labelText,
      required this.pageRoute,
    }
  );

  final String labelText;
  final String pageRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            TextButton(
            onPressed: () {
              if (pageRoute=='register') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>SignUpScreen()),
                );
              }
              if (pageRoute=='login') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>SignInScreen()),
                );
              }
            },
            child: Text(
              labelText,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}