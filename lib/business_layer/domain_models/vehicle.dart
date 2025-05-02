class Vehicle {
  String? make;
  String? model;
  String? containerName;
  int? similarity;
  String? externalId;

  Vehicle({
    this.make,
    this.model,
    this.containerName,
    this.similarity,
    this.externalId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    make: json["make"],
    model: json["model"],
    containerName: json["containerName"],
    similarity: json["similarity"],
    externalId: json["externalId"],
  );

  Map<String, dynamic> toJson() => {
    "make": make,
    "model": model,
    "containerName": containerName,
    "similarity": similarity,
    "externalId": externalId,
  };
}
