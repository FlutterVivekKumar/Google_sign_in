import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userCredential});

  final UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen'),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userCredential.user!.photoURL!,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 40),

              const Text('Name: ',       style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),),
              const SizedBox(
                height: 10,
              ),
              Text(userCredential.user!.displayName!,  style: const TextStyle(
                  fontSize: 25,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 10,
              ),
              const Text('Email: ',       style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),),
              const SizedBox(
                height: 10,
              ),
              Text(userCredential.user!.email!,  style: const TextStyle(
                  fontSize: 25,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 10,
              ),
              Text(userCredential.additionalUserInfo!.username ?? ''),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed:(){
                  signOutFromGoogle(context);
                },

                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),

              ),
           /*   InkWell(
                onTap:(){
                  signOutFromGoogle(context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.logout,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signOutFromGoogle(BuildContext context) async {
    await googleSignIn.signOut();

    await auth.signOut();
    Navigator.pop(context);
  }
}
