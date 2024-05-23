import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:internshala/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordObscured=true;

  Future<void> loginUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final String apiUrl = "http://159.89.95.7:5001/csapi/login";

      var email = _emailController.text;
      var password = _passwordController.text;

      Map<String, String> requestBody = {
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User Login successfult'),
              duration: Duration(seconds: 5),
            ),
          );
        } else {
          print('Failed to register user: ${response.statusCode}');
          print('Response body: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('failed to login'),
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
              child:
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    const Text(
                      'Hello\nSign in!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.only(right: 30,left:30),
                      child: Column(
                        children: [
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
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _isPasswordObscured,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(15),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordObscured = !_isPasswordObscured;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50,),
                          GestureDetector(
                            onTap: (){
                              loginUser(context);
                            },
                            child: Container(
                              height: 53,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white),
                              ),
                              child: const Center(child: Text('SIGN IN',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),),),
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