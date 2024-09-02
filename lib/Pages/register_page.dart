import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/home_page.dart';
import 'package:final_project/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final CollectionReference collRef = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Sign-In',
                  style: TextStyle(
                    fontSize: 40
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fullnameController,
                  decoration: const InputDecoration(
                      labelText: 'Fullname'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fullname harus diisi';
                    }
                    if (value.length < 5) {
                      return "Fullname harus lebih dari 5 kata";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email'
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email harus diisi';
                    }
                    if (value.contains('@')) {
                      return "Email harus berisi '@'";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password'
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password harus diisi';
                    }
                    if (value.length < 6) {
                      return "Password harus lebih dari 6 kata";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password'
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm password harus diisi';
                    }
                    if (value != _passwordController) {
                      return "Confirm password harus sama dengan password";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                    User? user = FirebaseAuth.instance.currentUser;
                    int balance = 0;

                    Auth().register(
                        email: _emailController.text, 
                        password: _passwordController.text
                    );

                    CollectionReference collRef = FirebaseFirestore.instance.collection('users');
                    collRef.doc(user?.uid).set({
                      'id': user?.uid,
                      'fullname': _fullnameController.text,
                      'username': _usernameController.text,
                      'number': _numberController.text,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'balance': balance
                    });

                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  }, 
                  child: const Text(
                    'Submit'
                  )
                )
              ],
            )
          ),
        ),
      )
    );
  }
}
