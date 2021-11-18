import 'package:flutter/material.dart';
import 'package:playground/post_model.dart';

import 'add_post.dart';
import 'http_service.dart';

class TestRestHTTP extends StatefulWidget {
  const TestRestHTTP({Key? key}) : super(key: key);

  @override
  _TestRestHTTPState createState() => _TestRestHTTPState();
}

class _TestRestHTTPState extends State<TestRestHTTP> {
  Future<List<Post>>? todos;
  var t;

  @override
  void initState() {
    todos = HttpMethods().getPosts();
    super.initState();
  }

  delPost(int id) {
    todos = HttpMethods().deletePost(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: todos,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            var content = snapshot.data as List;

            return ListView.builder(
                itemCount: content.length,
                itemBuilder: (ctx, i) {
                  return ListTile(
                    title: Text(content[i].title),
                    subtitle: Text(content[i].subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/add-post', arguments: content[i])
                               .then((value) { setState(() {}); });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () => delPost(content[i].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
