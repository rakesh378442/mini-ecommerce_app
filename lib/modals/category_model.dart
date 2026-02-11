class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(String json) {
    return CategoryModel(id: json, name: json);
  }
}
