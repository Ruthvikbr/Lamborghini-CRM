import 'dart:convert';


class Category{

  final List<String> categories;

  factory Category.fromMap(String response){
    return Category(
    categories: List<String>.from(json.decode(response).map((x) => x))
    );
  }

  Category({required this.categories});

}