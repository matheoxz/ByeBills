import 'dart:convert';

class UserModel {
  final String name;
  final String username;
  final String email;

  UserModel(
    this.name,
    this.username,
    this.email,
  );

  UserModel copyWith({
    String? name,
    String? username,
    String? email,
  }) {
    return UserModel(
      name ?? this.name,
      username ?? this.username,
      email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'],
      map['username'],
      map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(name: $name, username: $username, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ username.hashCode ^ email.hashCode;
}
