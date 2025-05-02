import 'package:car_on_sale_challenge/base/base_model.dart';

class ErrorModel extends BaseModel<ErrorModel> {
  String? msgKey;
  Params? params;
  String? message;

  ErrorModel({this.msgKey, this.params, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    msgKey: json["msgKey"],
    params: json["params"] == null ? null : Params.fromJson(json["params"]),
    message: json["message"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "msgKey": msgKey,
    "params": params?.toJson(),
    "message": message,
  };
}

class Params {
  String? delaySeconds;

  Params({this.delaySeconds});

  factory Params.fromJson(Map<String, dynamic> json) =>
      Params(delaySeconds: json["delaySeconds"]);

  Map<String, dynamic> toJson() => {"delaySeconds": delaySeconds};
}
