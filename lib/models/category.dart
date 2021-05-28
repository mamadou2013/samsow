
class Category{
  final String categoryId;
  final String categoryName;

  Category({this.categoryId,this.categoryName});

  Category.fromCloud(Map<String, dynamic> categoryJson)
    :categoryId = categoryJson['categoryId'],
    categoryName = categoryJson['categoryName'];
}