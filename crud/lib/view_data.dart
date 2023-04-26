import 'package:crud/update_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child('UserName');
    return Scaffold(
        appBar: AppBar(title: const Text('View Data')),
        body: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tileColor: Colors.lightBlue[100],
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          print(snapshot.key);
                          ref.child(snapshot.key!).remove();
                          print(snapshot.key);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpdateScreen(value: snapshot.key!),
                              ));
                        },
                        icon: const Icon(Icons.update),
                        color: Colors.green,
                      )
                    ],
                  ),
                  title: Text(
                    snapshot.value.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
