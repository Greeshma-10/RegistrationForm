import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class success_screen extends StatelessWidget {
  const success_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/tick.jpg",height: 200,),
          SizedBox(
            height: 30,
          ),
          Text(
            "Your account has been successfully created ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            textAlign: TextAlign.center,
            
          ),
          Text.rich(TextSpan(
              text: "Create another account? ",
              style: const TextStyle(
              color: Colors.black, fontSize: 15),
              children:[
              TextSpan(
                text: "Register",
                style: const TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, "register_forms");
                }),
              ],
            )),
        ]
      ),
    );
  }
}