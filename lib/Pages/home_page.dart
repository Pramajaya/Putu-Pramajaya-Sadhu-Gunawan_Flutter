import 'package:final_project/Pages/payment_page.dart';
import 'package:final_project/Pages/profile_page.dart';
import 'package:final_project/Pages/top_up_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Welcome'),
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                }, 
                icon: const Icon(Icons.person))
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          const Text('Rp. 0,00'),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TopUpPage()));
              }, 
              child: const Text('Top-Up')
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
              }, 
              child: const Text('Pay'))
            ],
          ),

        ],
      )
    );
  }
}
