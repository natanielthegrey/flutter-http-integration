import 'package:fetching_data_sample/api/request.dart';
import 'package:fetching_data_sample/models/post.dart';
import 'package:fetching_data_sample/models/post_mode.dart';
import 'package:flutter/material.dart';

class PostEditCreate extends StatefulWidget {
  final Post post;
  final PostMode mode;
  const PostEditCreate({Key? key, required this.post, required this.mode}) : super(key: key);

  @override
  State<PostEditCreate> createState() => _PostEditState();
}

class _PostEditState extends State<PostEditCreate> {

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.post.title);
    final bodyController = TextEditingController(text: widget.post.body);

    Widget _buildAlertDialog() {
      var title = widget.mode == PostMode.EDIT ? 'updated' : 'created';
      return AlertDialog(
        title: Text('Post $title successfully!'),
        content: Text('Your post have been $title with success!.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }

    void _createPost() {
      final newPost = Post(
        title: titleController.text,
        body: bodyController.text,
      );

      Requests.createPost(newPost).then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAlertDialog();
            });
      });
    }

    void _savePost() {
      final updatedPost = Post(
        id: widget.post.id,
        title: titleController.text,
        body: bodyController.text,
      );

      Requests.updatePost(widget.post.id, updatedPost).then((value) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _buildAlertDialog();
            });
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("${widget.mode == PostMode.EDIT ? "Edit" : "Create"} Post"),
      ),
      body: InkWell(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: 8,
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Body',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.mode == PostMode.EDIT ? _savePost : _createPost,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
