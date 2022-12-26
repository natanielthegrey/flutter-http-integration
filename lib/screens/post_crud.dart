import 'package:fetching_data_sample/api/request.dart';
import 'package:fetching_data_sample/models/post.dart';
import 'package:fetching_data_sample/models/request_mode.dart';
import 'package:flutter/material.dart';

class PostCrud extends StatefulWidget {
  final Post post;
  final RequestMode mode;
  const PostCrud({Key? key, required this.post, required this.mode})
      : super(key: key);

  @override
  State<PostCrud> createState() => _PostEditState();
}

class _PostEditState extends State<PostCrud> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.post.title);
    final bodyController = TextEditingController(text: widget.post.body);

    Widget _buildAlertDialog(String operation) {
      return AlertDialog(
        title: Text('Post $operation successfully!'),
        content: Text('Your post have been $operation with success!.'),
        actions: [
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
        ],
      );
    }

    void _loading() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    void _createPost() {
      _loading();
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context); //pop dialog

        final newPost = Post(
          title: titleController.text,
          body: bodyController.text,
        );

        Requests.createPost(newPost).then((value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildAlertDialog('created');
              });
        });
      });
    }

    void _editPost() {
      _loading();
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);

        final updatedPost = Post(
          id: widget.post.id,
          title: titleController.text,
          body: bodyController.text,
        );

        Requests.updatePost(widget.post.id, updatedPost).then((value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildAlertDialog('updated');
              });
        });
      });
    }

    void _deletePost() {
      _loading();
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context);

        Requests.deletePost(widget.post.id).then((value) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return _buildAlertDialog('deleted');
              });
        });
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
              "${widget.mode == RequestMode.PUT ? "Edit" : "Create"} Post"),
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
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurple),
                  ),
                  onPressed:
                      widget.mode == RequestMode.PUT ? _editPost : _createPost,
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.mode == RequestMode.PUT
            ? FloatingActionButton(
                onPressed: _deletePost,
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete),
              )
            : null);
  }
}
