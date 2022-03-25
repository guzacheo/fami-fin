class Transaction {
  String? id;
  String description = '';
  DateTime date = DateTime.now();
  int valueInCents = 0;

  Transaction({
    this.id,
    required this.description,
    required this.date,
    required this.valueInCents
  });

  Transaction.fromSnapshot(String? key, Map<dynamic, dynamic> json)
      : id = key,
        date = DateTime.parse(json['date'] as String),
        description = json['description'] as String,
        valueInCents = json['valueInCents'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'date': date.toString(),
    'description': description,
    'valueInCents': valueInCents,
  };
}