import 'package:crud/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();

  late DatabaseReference _ref;

  TextEditingController nameController = TextEditingController();
  @override
  
  void initState() {
    super.initState();
    nameController = TextEditingController();
    _ref = FirebaseDatabase.instance.ref().child('UserName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter your name'),
                    validator: (value) => value != null && value.isEmpty
                        ? 'Please enter your name !'
                        : null,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formkey.currentState!.validate()) {
                        return;
                      }
                      _formkey.currentState!.save();
                      _ref.push().set(nameController.text).then((value) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewData())));
                    },
                    child: const Text('Submit'),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
