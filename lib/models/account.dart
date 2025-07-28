class Account {
  final String email;

  Account({required this.email});

  static Account fromJson(Map<String, dynamic> json) => Account(email: json['email']);
}
