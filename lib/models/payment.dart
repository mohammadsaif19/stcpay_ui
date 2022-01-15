class PaymentInfo {
  late String expenseTitle;
  late String icon;
  late String amount;
  late bool isCashback;
  late String date;

  PaymentInfo({
    required this.expenseTitle,
    required this.icon,
    required this.amount,
    required this.isCashback,
    required this.date,
  });
  PaymentInfo.fromMap(Map<String, dynamic> data) {
    expenseTitle = data['expenseTitle'];
    icon = data['icon'];
    amount = data['amount'];
    isCashback = data['isCashback'];
    date = data['date'];
  }
}
