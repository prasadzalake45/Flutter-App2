import 'package:flutter/material.dart';
import 'items_list.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _usernameError;
  String? _passwordError;
  bool _isValid = false;

  // Validate Username in real-time
  void _validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        _usernameError = "Username cannot be empty";
      } else {
        _usernameError = null;
      }
      _updateFormValidity(); // Call this after validation
    });
  }

  // Validate Password in real-time
  void _validatePassword(String value) {
    setState(() {
      if (value.isEmpty) {
        _passwordError = "Password cannot be empty";
      } else if (value.length < 8) {
        _passwordError = "Must be at least 8 characters";
      } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
        _passwordError = "Must contain 1 uppercase letter";
      } else if (!RegExp(r'[a-z]').hasMatch(value)) {
        _passwordError = "Must contain 1 lowercase letter";
      } else if (!RegExp(r'\d').hasMatch(value)) {
        _passwordError = "Must contain 1 digit";
      } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        _passwordError = "Must contain 1 special character";
      } else {
        _passwordError = null;
      }
      _updateFormValidity(); // Call this after validation
    });
  }

  // Update form validity
  void _updateFormValidity() {
    setState(() {
      _isValid = (_usernameError == null && _passwordError == null) &&
          _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  // Login function
  void _login() {
    if (_isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemListPage()), // Navigate if valid
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            print("Menu Button Clicked");
          },
        ),
        title: Text(
          "Demo App",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Exit Clicked");
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  errorText: _usernameError,
                  border: OutlineInputBorder(),
                ),
                onChanged: _validateUsername,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  errorText: _passwordError,
                  border: OutlineInputBorder(),
                ),
                onChanged: _validatePassword,
                obscureText: true, // Hide password input
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isValid ? _login : null, // Disable button if invalid
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
