class Collection {
  final String employeeID;
  final String employeeName;
  final String companyName;
  final String runningTarget;
  final String runningcashIn;
  final String runningPercentage;
  final String stopTarget;
  final String stopcashIn;
  final String stopPercentage;
  final String totalTarget;
  final String totalcashIn;
  final String totalPercentage;
  final String collectionDate;

  Collection(
      {required this.employeeID,
      required this.employeeName,
      required this.companyName,
      required this.runningTarget,
      required this.runningcashIn,
      required this.runningPercentage,
      required this.stopTarget,
      required this.stopcashIn,
      required this.stopPercentage,
      required this.totalTarget,
      required this.totalcashIn,
      required this.totalPercentage,
      required this.collectionDate});

  factory Collection.fromJSON(Map<String, dynamic> json) {
    return Collection(
      employeeID: json['EMPLOYEE_ID'].toString(),
      employeeName: json['EMPLOYEE_NAME'].toString(),
      companyName: json['COMPANY_NAME'].toString(),
      runningTarget: json['RUNNING_TARGET'].toString(),
      runningcashIn: json['RUNNING_CASH_IN'].toString(),
      runningPercentage: json['RUNNING_PERCENTAGE'].toString(),
      stopTarget: json['STOP_TARGET'].toString(),
      stopcashIn: json['STOP_CASH_IN'].toString(),
      stopPercentage: json['STOP_PERCENTAGE'].toString(),
      totalTarget: json['TOTAL_TARGET'].toString(),
      totalcashIn: json['TOTAL_CASH_IN'].toString(),
      totalPercentage: json['TOTAL_PERCENTAGE'].toString(),
      collectionDate: json['COLLECTION_DATE'].toString(),
    );
  }
}
