class StatusDto {
  final String appId;
  final String mdm;
  final String spaceId;
  final String category;
  final String name;
  final String platform;
  final String status;
  final bool maintenance;
  final List<String> impactedFeatures;
  
  StatusDto({
    required this.appId,
    required this.mdm,
    required this.spaceId,
    required this.category,
    required this.name,
    required this.platform,
    required this.status,
    required this.maintenance,
    required this.impactedFeatures,
  });

  static const fromMapFactory = _$fromMap;

  factory StatusDto.fromMap(Map<String, dynamic> map) {
    return StatusDto(
      appId: map['AppID '],
      mdm: map['MDM'],
      spaceId: map['SpaceID'],
      category: map['Category'],
      name: map['Name'],
      platform: map['Platform'],
      status: map['Status'],
      maintenance: (map['Maintenance'] ?? false) as bool,
      impactedFeatures: List<String>.from(map['ImpactedFeatures']),
    );
  }
}

StatusDto _$fromMap(Map<String, dynamic> map) => StatusDto.fromMap(map);
