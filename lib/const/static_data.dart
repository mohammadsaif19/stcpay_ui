class StaticData {
  // The following data is for features boxes information
  final List<String> titleList = [
    'Add money',
    'Transfer to contact',
    'Riyadh season',
    'Qattah',
    'International transfer',
    'Local transfer',
  ];

  final List<String> imgFileName = [
    'wallet',
    'user-s',
    'kc',
    'pay',
    'globe',
    'bank',
  ];

  final List<bool> isNewFeaturesList = [
    false,
    false,
    true,
    true,
    false,
    false,
  ];

// This is dammy expense data and I used Map/json so you can understand how to handle all kind of data types in DART
  List<Map<String, dynamic>> expensesList = [
    {
      'expenseTitle': 'Cashback Promo',
      'icon': 'cashback.png',
      'amount': '0.50',
      'isCashback': true,
      'date': '09.01.2022 | 10:04',
    },
    {
      'expenseTitle': 'Whites Riyadh SA',
      'icon': 'laptop.png',
      'amount': '99.00',
      'isCashback': false,
      'date': '09.01.2022 | 10:03',
    },
  ];

// This are the add money sources info
  final List<String> addMoneySourcesTitle = [
    'Apple Pay',
    'Debit or credit card',
    'Bank transfer to stc pay',
    'SADAD - instant payments',
  ];

  final List<String> addMoneySourcesIcons = [
    'apple-pay',
    'credit-card',
    'bank',
    'sadad',
  ];

//Following list of title is for bottom nav bar
  final List<String> pagesTitle = [
    'Home',
    'Accounts',
    'Cards',
    'Market',
    'More',
  ];

//Following list of icon is for bottom nav bar
  final List<String> pagesTitleIcons = [
    'dashboard',
    'account',
    'credit-card',
    'store',
    'more',
  ];
}
