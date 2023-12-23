class Course {
  int id;
  String tenhocphan;
  String tengv;
  Course({required this.id, required this.tenhocphan, required this.tengv});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      tenhocphan: json['tenhocphan'],
      tengv: json['tengv'],
    );
  }
}
