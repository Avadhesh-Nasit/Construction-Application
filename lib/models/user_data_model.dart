class UserData {
  final String uid;
  final String displayName;
  final String creationDate;
  final String email;
  final int avatar;

  const UserData ({
    this.uid,
    this.displayName,
    this.creationDate,
    this.avatar,
    this.email,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      uid: json['UID'].toString(),
      displayName: json['DisplayName'].toString(),
      creationDate: json['CreationDate'].toString(),
      email: json['email'].toString(),
      avatar: json['Avatar'] as int,
    );
  }
}