class AccountModel {
  String id;
  String accountName;
  String accountFolder;

  AccountModel({
    required this.id,
    required this.accountName,
    required this.accountFolder,
  });

  factory AccountModel.fromJson({required Map<String, dynamic> json}) =>
      AccountModel(
        id: json['id'],
        accountName: json['accountName'],
        accountFolder: json['accountFolder'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'accountName': accountName,
        'accountFolder': accountFolder,
      };
}
