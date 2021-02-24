class Authorization {
  String access_token;
  int id;

  Authorization({
    this.access_token,
    this.id,
  });

  factory Authorization.fromMap(Map<String, dynamic> json) => Authorization(
    access_token: json["access_token"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "access_token": access_token,
    "id": id,
  };

}