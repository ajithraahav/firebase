import 'package:crud/view_data.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  const UpdateScreen({required this.value});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _ref = FirebaseDatabase.instance.ref().child('UserName');
  TextEditingController textContoller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: textContoller,
                      decoration: const InputDecoration(
                          hintText: 'Enter updated user name'),
                      validator: (value) => value != null && value.isEmpty
                          ? 'Please enter your updated name !'
                          : null,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: () {
                          if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          _formkey.currentState!.save();
                          String _text = textContoller.text;
                          _ref.child(widget.value).set(_text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewData(),
                              ));
                        },
                        child: const Text('Update'))
                  ],
                ))),
      ),
    );
  }
}
