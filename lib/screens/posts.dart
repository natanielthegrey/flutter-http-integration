import 'package:fetching_data_sample/api/request.dart';
import 'package:fetching_data_sample/screens/post_crud.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../models/request_mode.dart';

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
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: _fetchPosts,
                        child: const Text('Fetch All Posts')),
                    const Icon(Icons.search),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        child: const Text(
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
                    const Icon(Icons.delete),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    TextButton(
                        child: const Text('Fetch Posts by ID'), onPressed: _fetchPost),
                    const Icon(Icons.search),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: postIdController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Post ID',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostCrud(
                            mode: RequestMode.PUT,
                            post: _posts[index],
                          ),
                        ),),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _posts[index].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_posts[index].body)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
