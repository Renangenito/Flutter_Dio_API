import 'package:flutter/material.dart';
import 'package:dio_flutter_api/models/post_model.dart';
import 'package:dio_flutter_api/services/api_service.dart';

class DataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post>? _posts = []; // Inicializa a lista aqui
  bool _loading = false;
  String? _authToken; // Token JWT para autenticação
  
  List<Post>? get posts => _posts;
  String? get authToken => _authToken;
  bool get loading => _loading;

  Future<void> fetchPosts() async {
    _loading = true;
    notifyListeners();
    
    try {
      _posts = await _apiService.getPosts();
    } catch (error) {
      print('Erro ao buscar posts: $error');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createPost(Post post) async {
    try {
      Post newPost = await _apiService.createPost(post);
      print('Novo post criado: ${newPost.title}');
      _posts!.add(newPost); // Adiciona o novo post à lista
      notifyListeners(); // Notifica os listeners que os dados foram atualizados
    } catch (error) {
      print('Erro ao criar post: $error');
    }
  }
}
