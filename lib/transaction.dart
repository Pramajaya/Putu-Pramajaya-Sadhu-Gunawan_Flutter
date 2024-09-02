import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Transaction {
  Future<void> topup(int balance) async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);

    try {
      DocumentSnapshot docSnap = await userRef.get();

      if(docSnap.exists){
        int value = docSnap.get('balance');
        int newValue = value + balance;
        userRef.update({'balance': newValue});
      }
      
    } catch (e) {
      print(e);
    }
  }

  Future<void> payment(int balance) async {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(user?.uid);

      try {
        DocumentSnapshot docSnap = await userRef.get();

        if (docSnap.exists) {
          int value = docSnap.get('balance');
          int newValue = value - balance;
          await userRef.update({'balance': newValue});
        } else {
          print('User document does not exist.');
        }
      } catch (e) {
        print('Error updating balance: $e');
      }
    }
}