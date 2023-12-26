class User {
  late String userId;
  late String name;
  late String phone;
  late String email;

  User({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }
}
