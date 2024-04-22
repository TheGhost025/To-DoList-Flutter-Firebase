import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/signup.dart';

class LogInPage extends StatefulWidget {
  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      print("User logged in: ${userCredential.user!.email}");
      Navigator.pushReplacementNamed(context, '/todolist');
      // Navigate to next screen or perform post-login actions
    } catch (e) {
      print("Error logging in: $e");
      // Display error message or handle errors as needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error logging in. Please try again."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    icon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          // ignore: dead_code
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !isPasswordVisible,
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text("Log In")),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't have account yet"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text("SignUp"))
                ],
              )
            ],
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
