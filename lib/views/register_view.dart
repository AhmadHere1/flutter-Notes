import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter Your Email Here',
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter Your Password Here',
              labelText: 'Password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredentials =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredentials);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The email is already in use with another account.');
                } else if (e.code == 'invalid-email') {
                  print('The email is invalid.');
                } else if (e.code == 'operation-not-allowed') {
                  print('Password sign-in is disabled for this project.');
                } else if (e.code == 'user-disabled') {
                  print('The user account has been disabled.');
                } else {
                  print(e.code);
                }
              }
            },
            child: Text('Register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login/', (route) => false);
              },
              child: Text('Already Registered? Login Here')),
        ],
      ),
    );
  }
}
