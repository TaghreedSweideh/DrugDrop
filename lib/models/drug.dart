class Drug{
  final int id;
  final int tagId;
  final String imgUrl;
  final int dose;
  final int quantity;
  final int price;
  final String expiryDate;
  final String englishTradeName;
  final String arabicTradeName;
  final String englishScientificName;
  final String arabicScientificName;
  final String englishCompany;
  final String arabicCompany;
  final String englishDoseUnit;
  final String arabicDoseUnit;
  final String englishDescription;
  final String arabicDescription;

  Drug({
    required this.id,
    required this.tagId,
    required this.imgUrl,
    required this.dose,
    required this.quantity,
    required this.price,
    required this.expiryDate,
    this.englishTradeName = '',
    this.arabicTradeName = '',
    this.englishScientificName = '',
    this.arabicScientificName = '',
    this.englishCompany = '',
    this.arabicCompany = '',
    this.englishDoseUnit = '',
    this.arabicDoseUnit = '',
    this.englishDescription = '',
    this.arabicDescription = '',
});
}