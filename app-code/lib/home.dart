import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'course.dart';
import 'model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
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
        bottom: const TabBar(tabs: <Widget>[
          Tab(
            text: 'HOME',
            icon: Icon(Icons.home)
          ),
          Tab(
            text: 'EXPLORE',
            icon: Icon(Icons.explore),
          )
        ]),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute<ProfileScreen>(builder: (context) => ProfileScreen(actions: [SignedOutAction((context) {Navigator.of(context).pop();})],),),);},
              icon: const Icon(Icons.person), iconSize: 40, color: Colors.redAccent),
          const Padding(
            padding: EdgeInsets.only(right:10.0),
            child: IconButton(onPressed: null, icon: const Icon(Icons.favorite_rounded)),
          )
        ],
      ),
      body: const TabBarView(
          children: [
            HomeContent(),
            ExploreContent()
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ModelPage()));}, shape: const CircleBorder(), backgroundColor: Colors.yellow, child: const Icon(Icons.camera_outlined),),
    )
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Popular',style: TextStyle(fontSize: 30),),
            SizedBox(height: 10),
            SizedBox(height: 200, child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));},
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        SizedBox(height: 120, width: 150, child: Image.asset('images/pic1.jpg', fit: BoxFit.fill,),),
                        const InkWell(
                          splashColor: Colors.grey,
                          onTap: null,
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: Center(child: Text('SOME COURSE NAME'))
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      SizedBox(height: 120, width: 200, child: Image.asset('images/pic2.jpg', fit: BoxFit.fill,),),
                      const InkWell(
                        splashColor: Colors.grey,
                        onTap: null,
                        child: SizedBox(
                            height: 50,
                            width: 200,
                            child: Center(child: Text('SOME COURSE NAME'))
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    children: [
                      SizedBox(height: 120, width: 150, child: Image.asset('images/logo.jpeg', fit: BoxFit.fill,),),
                      const InkWell(
                        splashColor: Colors.grey,
                        onTap: null,
                        child: SizedBox(
                            height: 50,
                            width: 150,
                            child: Center(child: Text('SOME COURSE NAME'))
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),)
          ],
        ),
      ),
    );
  }
}

class ExploreContent extends StatelessWidget {
  const ExploreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        GestureDetector(
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));},
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.teal[100],
            child: const Text("Art 1"),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Art 2'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Art 3'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Art 4'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Art 5'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Art 6'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('art 7'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Art 8'),
        ),
      ],
    );
  }
}