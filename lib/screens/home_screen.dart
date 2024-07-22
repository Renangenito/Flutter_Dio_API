import 'package:dio_flutter_api/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio_flutter_api/models/post_model.dart';
import 'package:dio_flutter_api/providers/data_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                dataProvider.fetchPosts();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostsScreen()),
                );
              },
              child: Text('GET'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showPostDialog(context, dataProvider),
              child: Text('POST'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showPostDialog(BuildContext context, DataProvider dataProvider) async {
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
                  dataProvider.createPost(Post(title: title!, body: body!));
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
