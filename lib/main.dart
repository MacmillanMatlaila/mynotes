import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'MyNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(hintText: 'Enter your email'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: true,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //Initiaize Firebase

                      final email = _email.text;
                      final password = _password.text;

                      //Now use the option you chose in firebase Authentication
                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                      print(userCredential);
                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            default:
              return const Text('Loading');
          }
        },
      ),
    );
  }
}
