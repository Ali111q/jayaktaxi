class RegisterRequest {
  String name;
  int type;
  String? frontIdentity;
  String? backIdentity;
  String? frontResidence;
  String? backResidence;
  String? frontDriveLicense;
  String? backDriveLicense;
  String? frontCarLicense;
  String? backCarLicense;
  List<String> vehicleImages;

  RegisterRequest({
    required this.name, required this.type,
    this.frontIdentity,
    this.backIdentity,
    this.frontResidence,
    this.backResidence,
    this.frontDriveLicense,
    this.backDriveLicense,
    this.frontCarLicense,
    this.backCarLicense,
   required this.vehicleImages,

  });

  Map<String, dynamic> toJson() {
    return {
         'name':name,
      'type':type,
      'front_identity': frontIdentity,
      'back_identity': backIdentity,
      'front_residence': frontResidence,
      'back_residence': backResidence,
      'front_drive_license': frontDriveLicense,
      'back_drive_license': backDriveLicense,
      'front_car_license': frontCarLicense,
      'back_car_license': backCarLicense,
      'vehicle_images': vehicleImages,

   
    };
  }
}
