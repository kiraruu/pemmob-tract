class Activity {
  final String aktivitas;

  Activity({required this.aktivitas});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      aktivitas: json['activity'],
    );
  }
}

