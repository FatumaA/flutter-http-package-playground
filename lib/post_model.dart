class Post {

  final int id;
  final String title, subtitle, author;


  Post({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.author,
  });


  Map toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "author" : author
  };
 
}