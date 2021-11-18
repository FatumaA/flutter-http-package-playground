import 'dart:math';

import 'package:flutter/material.dart';
import 'package:playground/http_service.dart';

import 'post_model.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  Post? activePost;

  updatePost(Post post) async {
    await HttpMethods().updatePost(post);
    Navigator.of(context).pop();
  }

  createPost(Post post) async {
    await HttpMethods().addPost(post);
  }

  final _formKey = GlobalKey<FormState>();
  var title;
  var subtitle;
  var author;

    @override
    void dispose() {
    title.dispose();
    subtitle.dispose();
    author.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) activePost = args as Post;

    title = TextEditingController(text: activePost?.title);
    subtitle = TextEditingController(text: activePost?.subtitle);
    author = TextEditingController(text: activePost?.author);

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Form'),
      ),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          child: Column(
            children: [
              Text(
                activePost != null ? 'Edit Post' : 'Create New Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 48),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Post Title'),
                controller: title,
                validator: (value) {
                  if (value == '') {
                    return 'Post must have a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Post Description'),
                controller: subtitle,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a Post Author Name'),
                controller: author,
              ),
              SizedBox(height: 24),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.deepPurple[300],
                onPressed: () {
                  // TODO: check if title empty
                  // add logic
                  if (activePost?.id != null) {
                    var updatedPost = new Post(
                        id: activePost!.id,
                        title: title.text,
                        subtitle: subtitle.text,
                        author: author.text);
                    updatePost(updatedPost);
                  } else {
                    var newPost = new Post(
                        id: Random().nextInt(100),
                        title: title.text,
                        subtitle: subtitle.text,
                        author: author.text);
                    createPost(newPost);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Save Post',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
