# Fazendo chamadas API com Flutter

- Exemplo de classe de constantes para API:

```dart
class ApiConstants {
  // link base da nossa API
  static const String BASE_URL = 'https://jsonplaceholder.typicode.com';
  // recurso que queremos usar da API
  static const String POSTS = '/posts';
}
```

- Conversão do JSON retornado em um objeto nativo Dart:
  
```dart
factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
```

- Conversão de um objeto nativo Dart para JSON:

```dart
Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
```

- Exemplo de requisição GET sem parametros (busca de recurso):

```dart
static Future<List<Post>> getPosts() async {

    const String url = ApiConstants.BASE_URL + ApiConstants.POSTS;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return List<Post>.from(json.decode(response.body).map((x) => Post.fromJson(x)));
    } else {
      throw Exception('Failed to load posts');
    }
  }
```

![alt](gifs/fetch_all.gif)

- Exemplo de requisição GET com parametro (busca de recurso):

```dart
static Future<Post> getPost(int id) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
```

![alt](gifs/fetch_by_id.gif)

- Exemplo de requisição POST (envio de recurso):
  
```dart
static Future<dynamic> createPost(Post body) async {
    const String url = ApiConstants.BASE_URL + ApiConstants.POSTS;
    final response = await http.post(Uri.parse(url), body: json.encode(body));
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }
```

![alt](gifs/create.gif)

- Exemplo de requisição PUT (atualização de recurso)
  
```dart
static Future<dynamic> updatePost(int? id, Post body) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.put(Uri.parse(url), 
    body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update post');
    }
  }
```

![alt](gifs/update.gif)

- Exemplo de requisição DELETE (remoção de recurso):
  
```dart
static Future<dynamic> deletePost(int? id) async {
    final String url = '${ApiConstants.BASE_URL}${ApiConstants.POSTS}/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete post');
    }
  }
``` 

![alt](gifs/delete.gif)