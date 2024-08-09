class Collection {
  final String employeeID;
  final String employeeName;
  final String companyName;

  Collection({
    required this.employeeID,
    required this.employeeName,
    required this.companyName,
  });

  factory Collection.fromJSON(Map<String, dynamic> json) {
    return Collection(
      employeeID: json['EMPLOYEE_ID'],
      employeeName: json['EMPLOYEE_NAME'],
      companyName: json['COMPANY_NAME'],
    );
  }
}
