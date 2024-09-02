import 'package:final_project/Pages/home_page.dart';
import 'package:final_project/auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                  'Edit Profile',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fullnameController,
                  decoration: const InputDecoration(labelText: 'Fullname'),
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
                  controller: _numberController,
                  decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon harus diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String newFullname = _fullnameController.text;
                    String newNumber = _numberController.text;

                    if (_formKey.currentState?.validate() ?? false) {
                      await Auth().updateProfile(newFullname, newNumber);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    }
                  },
                  child: const Text('Confirm')
                )
              ],
            )
          )
        ),
      ),
    );
  }
}
