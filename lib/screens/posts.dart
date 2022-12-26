import 'package:fetching_data_sample/api/request.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> _posts = [];

  void _fetchPosts() {
    Requests.getPosts().then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Posts', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: _fetchPosts, child: const Text('Fetch Posts')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent)),
                  onPressed: () => setState(() {
                        _posts = [];
                      }),
                  child: const Text('Clear Posts')),
            ],
          ),
          Text('This is where the posts will be displayed',
              style: Theme.of(context).textTheme.subtitle1),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(8.0),
                  title: Text(_posts[index].title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                      textAlign: TextAlign.center),
                  subtitle: Text(_posts[index].body,
                      style: Theme.of(context).textTheme.bodyText2),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
