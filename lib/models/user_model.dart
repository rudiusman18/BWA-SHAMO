class UserModel {
  int id = 0;
  String name = '';
  String username = '';
  String email = '';
  String profilePhotoUrl = '';
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profilePhotoUrl,
    required this.token,
  });

// Mengambil data json
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  // mengirim data json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
