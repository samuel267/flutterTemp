class AuthUser {
  int id;
  String name;
  String profile_photo_path;
  String created_at;
  String profile_photo_url;

  AuthUser({
    this.name,
    this.profile_photo_path,
    this.created_at,
    this.profile_photo_url,
    this.id,
  });

  factory AuthUser.fromMap(Map<String, dynamic> json) => AuthUser(
    name: json["name"],
    created_at: json["created_at"],
    profile_photo_url: json["profile_photo_url"],
    profile_photo_path: json["profile_photo_path"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name":name,
    "profile_photo_path":profile_photo_path,
    "created_at":created_at,
    "profile_photo_url":profile_photo_url,
  };

}

/*
"id": 1,
        "name": "Kimotho",
        "email": "kimotho@gmail.com",
        "email_verified_at": null,
        "current_team_id": null,
        "profile_photo_path": null,
        "created_at": "2021-02-16T09:06:28.000000Z",
        "updated_at": "2021-02-16T09:06:28.000000Z",
        "profile_photo_url": "https://ui-avatars.com/api/?name=Kimotho&color=7F9CF5&background=EBF4FF"
 */