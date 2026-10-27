import 'dart:convert';

import 'package:cienfuegos_folklore/models/legend.dart';
import 'package:flutter/services.dart';

class LegendRepository {
  final AssetBundle _bundle;
  final String _path;

  LegendRepository(
      {AssetBundle? bundle, String path = 'assets/data/legends.json'})
      : _bundle = bundle ?? rootBundle,
        _path = path;

  Future<List<Legend>> loadLegends() async {
    final data =
        json.decode(await _bundle.loadString(_path)) as Map<String, dynamic>;
    return (data['legends'] as List)
        .map((e) => Legend.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
