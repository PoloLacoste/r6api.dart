class Season {
  Season({
    required this.id,
    required this.name,
    required this.color,
    required this.imageId,
    required this.releaseDate,
  });

  final int id;
  final String name;
  final String color;
  final String imageId;
  final DateTime releaseDate;
}
