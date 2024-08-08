class Visit {
  final String visitingNo;
  final String visitingDate;
  final String customerCode;
  final String customerName;
  final String drafterName;
  final String companyName;

  Visit({
    required this.visitingNo,
    required this.visitingDate,
    required this.customerCode,
    required this.customerName,
    required this.drafterName,
    required this.companyName,
  });

  factory Visit.fromJSON(Map<String, dynamic> json) {
    return Visit(
      visitingNo: json['VISITING_NO'],
      visitingDate: json['VISITING_DATE'],
      customerCode: json['CUSTOMER'],
      customerName: json['CUSTOMER_NAME'],
      drafterName: json['CREATED_BY_NAME'],
      companyName: json['COMPANY_NAME'],
    );
  }
}
