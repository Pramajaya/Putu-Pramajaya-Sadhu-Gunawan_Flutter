import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/Pages/edit_profile_page.dart';
import 'package:final_project/Pages/onboarding_page.dart';
import 'package:final_project/auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: Auth().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan.'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Data pengguna tidak ditemukan.'));
          }

          // Mengambil data dari snapshot
          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  userData['fullname'] ?? 'Fullname tidak ditemukan',
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 80),
                Text(
                  userData['username'] ?? 'Username tidak ditemukan',
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 80),
                Text(
                  userData['number'] ?? 'Nomor Telepon tidak ditemukan',
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 20),
                Text(
                  userData['email'] ?? 'Email tidak ditemukan',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfilePage()));
                  },
                  child: const Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Auth().logout(context: context);

                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Onboarding()));
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  getProfile() {}
}
