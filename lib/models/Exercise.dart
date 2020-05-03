class Exercise {
  final int id;
  final String description;
  final int categoryId;

  Exercise._({this.id, this.description, this.categoryId});
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return new Exercise._(
      id: json['id'],
      description: json['description'],
      categoryId: json['categoryId']
    );
  }
}