import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class IProcessProvider with ChangeNotifier {
  Future<void> init();

  Future<void> getTeamsBaseDirectory();

  Future<void> getTeamsExecuteDirectory();

  Future<void> openDirectory({required String directory});

  Future<void> makeDirectory({required String directory});

  Future<void> removeDirectory({required String directory});

  Future<void> launchTeamsInstance({required String directory});
}

class ProcessProvider with ChangeNotifier implements IProcessProvider {
  bool isLoading = false;
  String errorMessage = '';
  String teamsBaseDirectory = '';
  String teamsExecuteDirectory = '';

  @override
  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    await getTeamsBaseDirectory();
    await getTeamsExecuteDirectory();

    isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> getTeamsBaseDirectory() async {
    try {
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
    }
  }

  @override
  Future<void> getTeamsExecuteDirectory() async {
    try {
      final res = await Process.run(
        'ECHO',
        ['%USERPROFILE%\\AppData\\Local\\Microsoft\\Teams'],
        runInShell: true,
      );

      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
      final String resStr = res.stdout;
      teamsExecuteDirectory = resStr.trim();
    } catch (e) {
      errorMessage = 'Teams base directory not found';
    }
  }

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
  Future<void> removeDirectory({required String directory}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();

      final res = await Process.run(
        'rmdir',
        [directory],
        runInShell: true,
      );

      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
    } catch (e) {
      errorMessage = 'Error deleting profile directory, close Teams first';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> launchTeamsInstance({required String directory}) async {
    try {
      errorMessage = '';
      isLoading = true;
      notifyListeners();
      print(teamsExecuteDirectory);
      final res = await Process.run(
        'SET "USERPROFILE"=$directory\\%~n0 | $teamsExecuteDirectory\\Update.exe --processStart "Teams.exe"',
        [],
        runInShell: true,
      );

      if (res.stderr != null && res.stderr != '') {
        throw Exception();
      }
    } catch (e) {
      errorMessage = 'Error deleting profile directory, close Teams first';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
