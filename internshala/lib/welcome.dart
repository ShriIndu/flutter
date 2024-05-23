import 'package:flutter/material.dart';
import 'package:internshala/signup.dart';
import 'package:internshala/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/welcome.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            children: [
              SizedBox(
                height: 300,
              ),
              const Text('Welcome Back',style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
              ),),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('SIGN IN',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>SignupScreen()));
                },
                child: Container(
                  height: 53,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Center(child: Text('SIGN UP',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),),
                ),
              ),
              const SizedBox(height: 12,),
            ]
        ),
      ),

    );
  }
}