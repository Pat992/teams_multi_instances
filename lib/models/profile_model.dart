class ProfileModel {
  String id;
  String profileName;
  String profileFolder;

  ProfileModel({
    required this.id,
    required this.profileName,
    required this.profileFolder,
  });

  factory ProfileModel.fromJson({required Map<String, dynamic> json}) =>
      ProfileModel(
        id: json['id'],
        profileName: json['profileName'],
        profileFolder: json['profileFolder'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'profileName': profileName,
        'profileFolder': profileFolder,
      };
}
