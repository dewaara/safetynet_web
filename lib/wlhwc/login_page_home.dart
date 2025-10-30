import 'dart:convert';
import 'package:digi_calendar/apis/save_token.dart';
import 'package:digi_calendar/styles/styles.dart';
import 'package:digi_calendar/wlhwc/UploadPage.dart';
import 'package:digi_calendar/wlhwc/date_list_data.dart';
import 'package:digi_calendar/wlhwc/digi_dashbaord.dart';
import 'package:digi_calendar/wlhwc/digi_date_history.dart';
import 'package:flutter/material.dart';
import 'package:digi_calendar/apis/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedForm = 'login';
  final _formKey = GlobalKey<FormState>();

  // Controllers for login
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controllers for register
  final TextEditingController regNameController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();

  // Controller for forgot password
  final TextEditingController forgotEmailController = TextEditingController();

  final Color darkBlue = Colors.black;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // ✅ Check if already logged in
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token != null && token.isNotEmpty) {
      // Already logged in → redirect to DigiDashboard
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DigiDashboard()),
        );
      });
    }
  }

  // ✅ Login API call
  void _login() async {
    if (_formKey.currentState!.validate()) {
      final response = await ApiService.login(
        emailController.text,
        passwordController.text,
      );

      if (response.statusCode == 200) {
        emailController.clear();
        passwordController.clear();
        final data = jsonDecode(response.body);
        final token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DigiDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    }
  }

  // ✅ Registration API call
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final response = await ApiService.register(
        regNameController.text,
        regEmailController.text,
        regPasswordController.text,
      );

      if (response.statusCode == 201) {
        regNameController.clear();
        regEmailController.clear();
        regPasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${response.body}')),
        );
      }
    }
  }

  InputDecoration inputDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: darkBlue),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: darkBlue, width: 2),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );

  // ✅ Builds dynamic forms
  Widget _buildForm() {
    switch (_selectedForm) {
      case 'login':
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: inputDecoration('Email'),
                style: const TextStyle(color: Colors.black),
                validator: (value) => value == null || !value.contains('@')
                    ? 'Enter valid email'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: inputDecoration('Password'),
                style: const TextStyle(color: Colors.black),
                validator: (value) => value == null || value.length < 6
                    ? 'Min 6 characters'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                ),
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );

      case 'register':
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: regNameController,
                decoration: inputDecoration('Name'),
                style: const TextStyle(color: Colors.black),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: regEmailController,
                decoration: inputDecoration('Email'),
                style: const TextStyle(color: Colors.black),
                validator: (value) => value == null || !value.contains('@')
                    ? 'Enter valid email'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: regPasswordController,
                obscureText: true,
                decoration: inputDecoration('Password'),
                style: const TextStyle(color: Colors.black),
                validator: (value) => value == null || value.length < 6
                    ? 'Min 6 characters'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                ),
                child: const Text('Register',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );

      case 'forgot':
        return Column(
          children: [
            TextField(
              controller: forgotEmailController,
              decoration: inputDecoration('Email'),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Forgot Password button clicked');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
              ),
              child: const Text('Reset Password',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = Colors.blue.shade900;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.cyan.shade700,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Styles.scaffoldBackgroundColor,
            ),
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: Card(
                color: Colors.white60,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() => _selectedForm = 'login');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: darkBlue,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() => _selectedForm = 'register');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: darkBlue,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Register'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() => _selectedForm = 'forgot');
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: darkBlue,
                                textStyle: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Forgot Password'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
