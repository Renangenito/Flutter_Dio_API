import 'package:flutter/material.dart';
import 'package:dio_flutter_api/services/api_service.dart';
import 'package:dio_flutter_api/models/post_model.dart';
import 'package:dio_flutter_api/screens/posts_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  Future<Post>? _createdPostFuture;

  void _getPosts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostsScreen()),
    );
  }

  Future<void> _showPostDialog() async {
    String? title;
    String? body;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar um novo post'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Título',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                  ),
                  onChanged: (value) {
                    body = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enviar'),
              onPressed: () {
                if (title != null && body != null) {
                  setState(() {
                    _createdPostFuture = _createPost(title!, body!);
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Post> _createPost(String title, String body) async {
    Post newPost = Post(title: title, body: body);
    return await _apiService.createPost(newPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getPosts,
              child: Text('GET'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showPostDialog,
              child: Text('POST'),
            ),
            SizedBox(height: 20),
            _createdPostFuture == null
                ? Text('')
                : FutureBuilder<Post>(
                    future: _createdPostFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        Post post = snapshot.data!;
                        return Text('Post criado com sucesso:\n${post.title}\n${post.body}');
                      } else {
                        return Text('Nenhum post criado.');
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}