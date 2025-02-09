import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 250,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                suffixIcon: const Icon(Icons.search)
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute<ProfileScreen>(builder: (context) => ProfileScreen(actions: [SignedOutAction((context) {Navigator.of(context).pop();})],),),);},
              icon: const Icon(Icons.person), iconSize: 40, color: Colors.redAccent),
          const Padding(
            padding: EdgeInsets.only(right:10.0),
            child: IconButton(onPressed: null, icon: const Icon(Icons.favorite_rounded)),
          )
        ],
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Lesson 1'),
            children: [
              Text('Details about Lesson 1'),
              TextButton(onPressed: () {}, child: Text('Watch')),
            ],
          ),
          ExpansionTile(
            title: Text('Lesson 2'),
            children: [
              Text('Details about Lesson 2'),
              TextButton(onPressed: () {}, child: Text('Watch')),
            ],
          ),
        ],
      ),
    );
  }
}
