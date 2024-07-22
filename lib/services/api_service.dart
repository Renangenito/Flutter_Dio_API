import 'package:dio/dio.dart';
import 'package:dio_flutter_api/models/post_model.dart';
import 'package:dio_flutter_api/interceptors/logging_interceptor.dart';

class ApiService {
  final Dio _dio = Dio();
  final cancelaToken = CancelToken();

  ApiService() {
    _dio.interceptors.add(LoggingInterceptor());
    _dio.options.connectTimeout = 5000; // 5 segundos de timeout para conexão
    _dio.options.receiveTimeout = 3000; // 3 segundos de timeout para receber a resposta
  }

  final String baseUrl = 'https://jsonplaceholder.typicode.com/';

  Future<List<Post>> getPosts() async {
    try {
      Response response = await _dio.get('$baseUrl/posts', cancelToken: cancelaToken);
      cancelaToken.cancel('Operação cancelada pelo usuário.');
      List<Post> posts = (response.data as List).map((json) => Post.fromJson(json)).toList();

      return posts;
    } catch (error) {
      throw Exception('Erro ao tentar carregar os posts: $error');
    }
  }

  Future<Post> createPost(Post post) async {
    try {
      Response response = await _dio.post(
        '$baseUrl/posts',
        data: {
          'userId': 8,
          'title': post.title,
          'body': post.body,
        },
      );
      return Post.fromJson(response.data);
    } catch (error) {
      throw Exception('Erro ao tentar criar o post: $error');
    }
  }
}