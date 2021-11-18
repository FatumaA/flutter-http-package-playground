import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'post_model.dart';

class HttpMethods {
  String baseUrl = "http://localhost:3000/posts/";

  // get all posts
  Future<List<Post>> getPosts() async {
  final response = await http.get(Uri.parse('$baseUrl'));
    List<Post> posts = [];
    if (response.statusCode == 200) {
        var data = json.decode(response.body);
        data.forEach((d) => posts.add(Post(id: d["id"], title: d["title"], subtitle: d["subtitle"], author: d["author"])));
        print(posts);
        return posts; 
      } else {
          throw Exception('Failed to load todos');
      }
  }

  // Post - add posts
  Future<List<Post>> addPost(Post post) async {
     final newPost = json.encode(post);
    final response = await http.post(Uri.parse('$baseUrl'), 
                                      headers: {"Content-Type": "application/json"},
                                      body: newPost);
    if(response.statusCode == 200) {
      // return getPosts();
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed Post Operation');
    }
  }

  // update exisiting post
  Future<List<Post>> updatePost(Post post) async {
    final updatedPost = json.encode(post);
      final response = await http.put(Uri.parse('$baseUrl/${post.id}'), 
                                      headers: {"Content-Type": "application/json"},
                                      body: updatedPost);
      if(response.statusCode == 200) {
        // return getPosts();
        return jsonDecode(response.body);
      }
      else {
        throw Exception('Unable to update resource');
      }
  } 

  // delete - delete a post
  Future<List<Post>>  deletePost(id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    
    if(response.statusCode == 200) {
      return getPosts();
      // return jsonDecode(response.body);
    }
    else {
      throw Exception('Unable to delete resource');
    }
  } 

}

