import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teams_multi_instances/models/account_model.dart';

abstract class IAccountProvider extends ChangeNotifier {
  Future<void> init();

  Future<void> addAccount({required AccountModel accountModel});

  Future<void> removeAccount({required AccountModel accountModel});

  Future<void> writeAccounts({required List<String> accountStringList});

  List<String> toList();
}

class AccountProvider extends ChangeNotifier implements IAccountProvider {
  String errorMessage = '';
  final String key = 'teams_accounts';
  final SharedPreferences sharedPreferences;
  final List<AccountModel> accounts = [];

  AccountProvider({required this.sharedPreferences});

  @override
  Future<void> init() async {
    try {
      final accountsFromShPr = sharedPreferences.getStringList(key);
      final accountsFuture = await Future.value(accountsFromShPr ?? []);

      for (final account in accountsFuture) {
        accounts.add(
          AccountModel.fromJson(
            json: jsonDecode(account),
          ),
        );
      }
    } catch (e) {
      errorMessage = 'Error getting saved accounts';
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> addAccount({required AccountModel accountModel}) async {
    try {
      accounts.add(accountModel);
      final accountStringList = toList();
      await writeAccounts(accountStringList: accountStringList);
    } catch (e) {
      errorMessage = 'Error saving account';
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> removeAccount({required AccountModel accountModel}) async {
    try {
      accounts.remove(accountModel);
      final accountStringList = toList();
      await writeAccounts(accountStringList: accountStringList);
    } catch (e) {
      errorMessage = 'Error deleting account';
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<void> writeAccounts({required List<String> accountStringList}) async {
    final res = await sharedPreferences.setStringList(key, accountStringList);

    if (!res) {
      throw Exception();
    }
  }

  @override
  List<String> toList() {
    final List<String> accountStringList = [];
    for (final account in accounts) {
      accountStringList.add(
        json.encode(
          account.toJson(),
        ),
      );
    }
    return accountStringList;
  }
}
