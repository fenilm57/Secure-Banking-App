class Fd {
  String id;
  String name;
  String bankname;
  String interest;
  String amount;
  String maturityAmount;
  String startDate;
  String endDate;

  Fd({
    this.id,
    this.amount,
    this.bankname,
    this.endDate,
    this.interest,
    this.maturityAmount,
    this.name,
    this.startDate,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bankname': bankname,
      'interest': interest,
      'amount': amount,
      'maturityAmount': maturityAmount,
      'startdate': startDate,
      'enddate': endDate,
    };
  }
}
