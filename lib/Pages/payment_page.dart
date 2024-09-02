import 'package:final_project/Pages/home_page.dart';
import 'package:final_project/transaction.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPage();
}

class _PaymentPage extends State<PaymentPage> {
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Tujuan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tujuan harus diisi';
                    }
                    return null;
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState?.validate() ?? false) {
                        int nominalValue = int.tryParse(_nominalController.text) ?? 0;

                        if (nominalValue > 0) {
                          Transaction().payment(nominalValue).then((value) {
                            Navigator.pop(context);
                          }).catchError((error) {
                            print('Failed to pay: $error');
                          });
                        } else {
                          print('Invalid nominal value');
                        }
                      }

                      Navigator.pop(context,MaterialPageRoute(builder: (context) => const HomePage()));
                    },
                    child: const Text('Pay'))
              ],
            )),
      ),
    ));
  }
}
