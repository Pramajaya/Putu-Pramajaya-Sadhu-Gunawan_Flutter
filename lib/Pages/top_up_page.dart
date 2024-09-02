import 'package:final_project/transaction.dart';
import 'package:flutter/material.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {

  final TextEditingController _nominalController = TextEditingController();

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
                  'Payment',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _nominalController,
                  decoration: const InputDecoration(labelText: 'Nominal'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nominal harus diisi';
                    }
                    if (int.parse(value).toInt() <= 0) {
                      return "Nominal tidak boleh 0";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                      if (_formKey.currentState?.validate() ?? false) {
                        int nominalValue = int.tryParse(_nominalController.text) ?? 0;

                        if (nominalValue > 0) {
                          Transaction().topup(nominalValue).then((value) {
                            Navigator.pop(context);
                          }).catchError((error) {
                            print('Failed to top-up: $error');
                          });
                        } else {
                          print('Invalid nominal value');
                        }
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