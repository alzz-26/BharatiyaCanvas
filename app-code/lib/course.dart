import 'package:flutter/material.dart';
import 'lesson.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

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
      body: Column(
        children: [
          Text('Course Name', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
          SizedBox(height: 20,),
          Image.asset('images/logo.jpeg'), // Sample path
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Detailed description about the artwork.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LessonPage())),
                child: const Text('Enroll'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
