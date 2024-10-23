class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  // Método para converter o JSON em um objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
    );
  }

  // Método para converter um objeto User em JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
