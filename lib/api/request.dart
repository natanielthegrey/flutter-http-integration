import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fetching_data_sample/api/constants.dart';

import '../models/post.dart';

class Requests {

  static Future<List<Post>> getPosts() async {
    const String url = ApiConstants.BASE_URL + ApiConstants.POSTS;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Post>.from(json.decode(response.body).map((x) => Post.fromJson(x)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<Post> getPost(int id) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  static Future<dynamic> createPost(Post body) async {
    const String url = ApiConstants.BASE_URL + ApiConstants.POSTS;
    final response = await http.post(Uri.parse(url), body: json.encode(body));
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }

  static Future<dynamic> updatePost(int? id, Post body) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.put(Uri.parse(url), 
    body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update post');
    }
  }

  static Future<dynamic> deletePost(int id) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete post');
    }
  }

}