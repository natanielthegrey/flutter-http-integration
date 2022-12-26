import 'package:fetching_data_sample/api/request.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final postIdController = TextEditingController();

  List<Post> _posts = [];

  void _fetchPosts() {
    Requests.getPosts().then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  void _fetchPost() {
    Requests.getPost(int.parse(postIdController.text)).then((post) {
      setState(() {
        _posts = [post];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  TextButton(
                      child: Text('Fetch All Posts'), onPressed: _fetchPosts),
                  Icon(Icons.search),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      child: Text(
                        'Clear Posts',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _posts = [];
                        });
                      }),
                  Icon(Icons.delete),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  TextButton(
                      child: Text('Fetch Posts by ID'), onPressed: _fetchPost),
                  Icon(Icons.search),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                      controller: postIdController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Post ID',
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: null,
                    title: Text(
                      _posts[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(_posts[index].body),

                  ),
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
