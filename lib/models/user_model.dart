class UserModel {
  String name = '';
  String email = '';
  String industry = '';
  String seniority = '';
  String jobType = '';

  UserModel.empty();

  UserModel({
    required this.name,
    required this.email,
    required this.industry,
    required this.seniority,
    required this.jobType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      industry: json['industry'],
      seniority: json['seniority'],
      jobType: json['jobType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'industry': industry,
      'seniority': seniority,
      'jobType': jobType,
    };
  }
}
