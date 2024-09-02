import 'package:final_project/Pages/login_page.dart';
import 'package:final_project/Pages/register_page.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const LoginPage())
                );
              }, 
              child: const Text('Sign-In')
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const RegisterPage())
                );
              }, 
              child: const Text('Sign-Up')
            )
          ],
        )
      ),
    );
  }
}