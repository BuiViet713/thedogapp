class GetAllDogModel {
  Map<String, List<String>> breeds;

  GetAllDogModel({required this.breeds});

  factory GetAllDogModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json;

    Map<String, List<String>> breeds = {};

    data.forEach((key, value) {
      if (value is List) {
        breeds[key] = List<String>.from(value.whereType<String>());
      } else {
        breeds[key] = [];
      }
    });

    return GetAllDogModel(breeds: breeds);
  }
}
