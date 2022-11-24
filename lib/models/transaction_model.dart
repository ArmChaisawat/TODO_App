class TransactionModel {
  String title;
  bool value;
  int id;
  TransactionModel({
    required this.id,
    required this.title,
    this.value = false,
  });
}
