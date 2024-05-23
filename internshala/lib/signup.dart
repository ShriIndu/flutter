import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';


class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final String apiUrl = "http://159.89.95.7:5001/csapi/signup";

      var firstname = _firstnameController.text;
      var lastname = _lastnameController.text;
      var email = _emailController.text;
      var password = _passwordController.text;

      Map<String, String> requestBody = {
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'password': password,
      };
      String jsonBody = json.encode(requestBody);
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonBody,
        );
        if (response.statusCode == 200) {
          print('User registered successfully');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User registered successfully'),
              duration: Duration(seconds: 5),
            ),
          );
        } else {
          print('Failed to register user: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error occurred while registering user'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } catch (e) {
        print('Error occurred while registering user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/signup.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 220,
                    ),
                    const Text(
                      'Hello\nSign up!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _firstnameController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your First Name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _lastnameController,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Please enter your Last Name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Invalid email format';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                              ),
                              style: const TextStyle(color: Colors.white),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              registerUser(context);
                            },
                            child: Container(
                              height: 53,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                              ),
                              child: const Center(
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}