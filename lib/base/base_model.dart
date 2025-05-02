abstract class BaseModel<T>{
  static T fromJson<T>(Map<String, dynamic> json, T Function(Map<String, dynamic>) creator) => creator(json);
  Map<String, dynamic> toJson();
}