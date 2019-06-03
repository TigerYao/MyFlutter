
class PostList {
  List<Post> postList;
  PostList({this.postList});
  factory PostList.fromJson(List<dynamic> listJson){
    List<Post> postList = listJson.map((m) => Post.fromJson(m)).toList();
    return PostList(postList:  postList);
  }
}
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}