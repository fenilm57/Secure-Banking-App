class Name {
  String id;
  String name;
  Name({
    this.id,
    this.name,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
