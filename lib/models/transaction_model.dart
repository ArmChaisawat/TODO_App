class TransactionModel {
  String title;
  dynamic value;
  dynamic id;
  TransactionModel({
    required this.id,
    required this.title,
    this.value = false,
  });
}
