class Overdue {
  final String businessArea;
  final String date;
  final String customer;
  final String customerName;
  final String groupCustomer;
  final String groupCustomerName;
  final String salesName;
  final String overdueValue;
  final String stopValue;
  final String beginningValue;
  final String debitValue;
  final String creditValue;
  final String endingValue;

  Overdue({
    required this.businessArea,
    required this.date,
    required this.customer,
    required this.customerName,
    required this.groupCustomer,
    required this.groupCustomerName,
    required this.salesName,
    required this.overdueValue,
    required this.stopValue,
    required this.beginningValue,
    required this.debitValue,
    required this.creditValue,
    required this.endingValue,
  });

  factory Overdue.fromJSON(Map<String, dynamic> json) {
    return Overdue(
      businessArea: json['BUSINESS_AREA'].toString() +
          ' - ' +
          json['BUSINESS_AREA_DESC'].toString(),
      date: json['MMDDYYY'].toString(),
      customer: json['CUSTOMER'].toString(),
      customerName: json['CUSTOMER_NM'].toString(),
      groupCustomer: json['GROUP_CUSTOMER'].toString(),
      groupCustomerName: json['GROUP_CUSTOMER_NM'].toString(),
      salesName: json['SALESMAN'].toString(),
      overdueValue: json['OVERDUE'].toString(),
      stopValue: json['STOP'].toString(),
      beginningValue: json['BEGINNING'].toString(),
      debitValue: json['DEBIT'].toString(),
      creditValue: json['CREDIT'].toString(),
      endingValue: json['ENDING'].toString(),
    );
  }
}
