import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playground/add_post.dart';
import 'package:playground/test-rest-http.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.hindMaduraiTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.deepPurple,
      ),
      routes: {'/': (ctx) => MyHomePage(), '/add-post': (ctx) => PostForm()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   @override
  void initState() {
    setState(() {
      
    });
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playground'),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple[300],
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.fromLTRB(0, 0, 10, 24),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () =>  Navigator.of(context)
                              .pushNamed('/add-post')
                              .then((value) { setState(() {}); }),
        ),
      ),
      body: TestRestHTTP(),
    );
  }
}
