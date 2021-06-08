class Account {
  String id;
  String name;
  String bankName;
  String accountno;
  String ifscCode;
  Account({
    this.id,
    this.accountno,
    this.bankName,
    this.ifscCode,
    this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'bankname': bankName,
      'accountno': accountno,
      'ifsc': ifscCode,
    };
  }
}
