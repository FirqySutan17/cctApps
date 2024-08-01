class Plant {
  final String code;
  final String codeName;

  Plant({required this.code, required this.codeName});

  factory Plant.fromJSON(Map<String, dynamic> json) {
    return Plant(
      code: json['CODE'],
      codeName: json['CODE_NAME'],
    );
  }
}
