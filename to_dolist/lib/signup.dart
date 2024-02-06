import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confermPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isConfermPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    label: Text("Password"),
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
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
                    )),
                obscureText: !isPasswordVisible,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: confermPasswordController,
                decoration: InputDecoration(
                    label: Text("Conferm Password"),
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfermPasswordVisible
                            // ignore: dead_code
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfermPasswordVisible = !isConfermPasswordVisible;
                        });
                      },
                    )),
                obscureText: !isConfermPasswordVisible,
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    print("Email: " + emailController.text);
                    print("password: " + passwordController.text);
                    print(
                        "Conderm password: " + confermPasswordController.text);
                  },
                  child: Text("Sign Up")),
            ],
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
