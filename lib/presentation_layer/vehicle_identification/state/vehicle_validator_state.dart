class VehicleValidatorState {
  String vin;
  String? vinError;
  bool isValid;
  VehicleValidatorState({this.vin = '', this.vinError, this.isValid = false});

  VehicleValidatorState copyWith({
    String? vin,
    String? vinError,
    bool? isValid,
  }) {
    return VehicleValidatorState(
      vin: vin ?? this.vin,
      vinError: vinError ?? this.vinError,
      isValid: isValid ?? this.isValid,
    );
  }
}
