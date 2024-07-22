import 'package:flutter/material.dart';
import 'package:dio_flutter_api/models/post_model.dart';
import 'package:provider/provider.dart';
import 'package:dio_flutter_api/providers/data_provider.dart';

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Títulos'),
      ),
      body: RefreshIndicator(
        onRefresh: () => dataProvider.fetchPosts(),
        child: ListView.builder(
          itemCount: dataProvider.posts?.length ?? 0,
          itemBuilder: (context, index) {
            Post post = dataProvider.posts![index];
            return Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(post.title),
              ),
            );
          },
        ),
      ),
    );
  }
}
