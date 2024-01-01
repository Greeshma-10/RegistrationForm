import 'package:regiter_forms/saving.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String firstName= "";
  String lastName="";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "REGISTER",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                            "Register to create your account",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Image.asset("assets/images/signup.jpg"),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "First name",
                              prefixIcon: Icon(
                                Icons.person,
                                color:Colors.deepPurpleAccent,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          onChanged: (val) {
                            setState(() {
                              firstName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name cannot be empty";
                            }
                          },
                        ),

                        SizedBox(height: 10,),


                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Last name",
                              prefixIcon: Icon(
                                Icons.person,
                                color:Colors.deepPurpleAccent,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          onChanged: (val) {
                            setState(() {
                              lastName = val;
                            });
                          },
                          ),

                        const SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          decoration:InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.deepPurpleAccent,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },
                        ),

                        const SizedBox(height: 10),

                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.deepPurpleAccent,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurpleAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        
                      ],
                    )),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(firstName,lastName, email, password)
          .then((value) async {
        if (value == true) {
          
          await functions.saveUserEmailSF(email);
          await functions.saveUserNameSF(firstName);
          Navigator.pushNamed(context, "success_screen");
         
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
}
