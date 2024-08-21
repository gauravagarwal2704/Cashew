import 'package:flutter/material.dart';
import 'package:budget/struct/settings.dart';

class GlobalState with ChangeNotifier {
  bool _isSelectingAccounts = false;
  List<String> _selectedAccountIds = [];

  bool get isSelectingAccounts => _isSelectingAccounts;
  List<String> get selectedAccountIds => _selectedAccountIds;

  void setSelectingAccounts(bool value) {
    _isSelectingAccounts = value;
    notifyListeners();
  }

  void addAccountId(String accountId) {
    if (!_selectedAccountIds.contains(accountId)) {
      _selectedAccountIds.add(accountId);
    }
    notifyListeners();
  }

  void removeAccountId(String accountId) {
    if (_selectedAccountIds.contains(accountId)) {
      _selectedAccountIds.remove(accountId);
    }
    notifyListeners();
  }

  void clearSelectedAccounts() {
    _selectedAccountIds.clear();
    appStateSettings["selectedWalletPk"] = "";
    _isSelectingAccounts = false;
    notifyListeners();
  }
}

final globalState = GlobalState();