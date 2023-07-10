const String tableName = "hasan";

class MainModel {
  final int? id;
  final String? fName;
  final String? lName;
  final int? code;

  MainModel({
    this.id,
    this.code,
    this.fName,
    this.lName,
  });

  factory MainModel.fromJson(Map<String, dynamic> data) {
    return MainModel(
      id: data[FiledDb.id],
      fName: data[FiledDb.fName],
      lName: data[FiledDb.lName],
      code: data[FiledDb.code],
    );
  }

  Map<String, Object?> toJson() {
    return {
      FiledDb.id: id,
      FiledDb.fName: fName,
      FiledDb.lName: lName,
      FiledDb.code: code,
    };
  }

  MainModel copy({int? id, int? code, String? fName, String? lName}) {
    return MainModel(
      id: id ?? this.id,
      code: code ?? this.code,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
    );
  }
}

class FiledDb {
  static const String id = "_id";
  static const String code = "_code";
  static const String fName = "_fName";
  static const String lName = "_lName";
  static List<String> allValues = <String>[
    id,
    code,
    lName,
    fName,
  ];
}
