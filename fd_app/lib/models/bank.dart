class Bank {
  String id;
  String bankname;
  Bank({
    this.id,
    this.bankname,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bankname': bankname,
    };
  }
}
