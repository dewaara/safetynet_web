import 'package:digi_calendar/apis/api_service.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final response = await ApiService.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      if (response.statusCode == 201) {
        // Registration successful
        print('User registered successfully');
      } else {
        // Handle error
        print('Registration failed: ${response.body}');
      }
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final response = await ApiService.login(
        _emailController.text,
        _passwordController.text,
      );
      if (response.statusCode == 200) {
        // Login successful
        print('User logged in successfully');
      } else {
        // Handle error
        print('Login failed: ${response.body}');
      }
    }
  }

  void _toggleForm() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isLogin ? 'Login' : 'Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (!isLogin)
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                          .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: isLogin ? _login : _register,
                child: Text(isLogin ? 'Login' : 'Register'),
              ),
              TextButton(
                onPressed: _toggleForm,
                child: Text(isLogin
                    ? 'Don\'t have an account? Register'
                    : 'Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
