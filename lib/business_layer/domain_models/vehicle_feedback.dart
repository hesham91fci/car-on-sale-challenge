class VehicleFeedback {
  int? id;
  String? feedback;
  DateTime? requestedAt;
  String? make;
  String? model;
  String? externalId;
  String? fkSellerUser;
  int? price;
  bool? positiveCustomerFeedback;
  String? fkUuidAuction;
  String? origin;
  String? estimationRequestId;

  VehicleFeedback({
    this.id,
    this.feedback,
    this.requestedAt,
    this.make,
    this.model,
    this.externalId,
    this.fkSellerUser,
    this.price,
    this.positiveCustomerFeedback,
    this.fkUuidAuction,
    this.origin,
    this.estimationRequestId,
  });

  factory VehicleFeedback.fromJson(Map<String, dynamic> json) =>
      VehicleFeedback(
        id: json["id"],
        feedback: json["feedback"],
        requestedAt:
            json["requestedAt"] == null
                ? null
                : DateTime.parse(json["requestedAt"]),
        make: json["make"],
        model: json["model"],
        externalId: json["externalId"],
        //fkSellerUser: json['_fk_sellerUser'] ?? '',
        price: json["price"],
        positiveCustomerFeedback: json["positiveCustomerFeedback"],
        fkUuidAuction: json["_fk_uuid_auction"],
        origin: json["origin"],
        estimationRequestId: json["estimationRequestId"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "feedback": feedback,
    "requestedAt": requestedAt?.toIso8601String(),
    "make": make,
    "model": model,
    "externalId": externalId,
    "_fk_sellerUser": fkSellerUser,
    "price": price,
    "positiveCustomerFeedback": positiveCustomerFeedback,
    "_fk_uuid_auction": fkUuidAuction,
    "origin": origin,
    "estimationRequestId": estimationRequestId,
  };
}
