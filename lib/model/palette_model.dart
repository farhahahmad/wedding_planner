// This code defines a PaletteModel class with properties representing palette information

class PaletteModel {
  String? id;
  String? color1;
  String? color2;
  String? color3;
  String? theme;

  PaletteModel({
    required this.id,
    required this.theme,
    required this.color1,
    required this.color2,
    required this.color3
  });
}