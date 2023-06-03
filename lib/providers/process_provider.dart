import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class IProcessProvider with ChangeNotifier {
  Future<void> openDirectory({required String directory});

  Future<void> makeDirectory({required String directory});

  Future<void> getTeamsBaseDirectory();
}

class ProcessProvider with ChangeNotifier implements IProcessProvider {
  bool isLoading = false;
  String errorMessage = '';
  String teamsBaseDirectory = '';

  @override
  Future<void> openDirectory({required String directory}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      final res = await Process.run(
        '%windir%\\explorer.exe',
        [directory],
        runInShell: true,
      );

      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
    } catch (e) {
      errorMessage = 'Error opening profile directory';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> makeDirectory({required String directory}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      final res = await Process.run(
        'mkdir',
        [directory],
        runInShell: true,
      );

      print(res.stderr);
      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
    } catch (e) {
      errorMessage = 'Error creating profile directory';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> getTeamsBaseDirectory() async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      final res = await Process.run(
        'ECHO',
        ['%LOCALAPPDATA%\\Microsoft\\Teams'],
        runInShell: true,
      );

      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
      final String resStr = res.stdout;
      teamsBaseDirectory = resStr.trim();
    } catch (e) {
      errorMessage = 'Teams base directory not found';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
