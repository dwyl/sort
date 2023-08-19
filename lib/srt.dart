library sort;

import 'dart:convert';
import 'dart:io';

/// Class holding the sort type
class SortInfo {
  final int id;
  final String code;
  final String label;

  SortInfo(this.id, this.code, this.label);

  factory SortInfo.fromJson(Map<String, dynamic> json) {
    return SortInfo(json['id'], json['code'], json['label']);
  }
}

/// Static class that can be invoked to fetch the sort
class Sort {
  /// Loads the information from the `.json` file containing the sort list.
  static Future<List<SortInfo>> _sortList() async {
    String jsonString = await File('sort.json').readAsString();
    List<dynamic> jsonList = json.decode(jsonString);
    List<SortInfo> sort =
        jsonList.map((json) => SortInfo.fromJson(json)).toList();
    return sort;
  }

  /// Returns a list of sort records
  static Future<List<SortInfo>> get() async {
    return await _sortList();
  }
}
