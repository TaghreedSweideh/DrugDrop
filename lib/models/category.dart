import 'package:flutter/material.dart';

import 'tag.dart';

class Categories with ChangeNotifier {
  final int id;
  final String en_name;
  final String ar_name;
  List<Tag> tags;

  Categories({
    required this.id,
    required this.en_name,
    required this.ar_name,
    this.tags = const [],
  });
}
