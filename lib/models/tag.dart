import '../providers/drug_data.dart';

class Tag {
  final int id;
  final String name;
  List<Drug> drugs;

  Tag({
    required this.id,
    required this.name,
    required this.drugs,
  });
}