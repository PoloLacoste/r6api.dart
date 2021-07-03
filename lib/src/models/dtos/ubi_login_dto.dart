class UbiLoginDto {
  UbiLoginDto({
    required this.platformType,
    required this.ticket,
    required this.profileId,
    required this.userId,
    required this.nameOnPlatform,
    required this.environment,
    required this.expiration,
    required this.spaceId,
    required this.clientIp,
    required this.clientIpCountry,
    required this.serverTime,
    required this.sessionId,
    required this.sessionKey,
  });

  final String platformType;
  final String ticket;
  final String profileId;
  final String userId;
  final String nameOnPlatform;
  final String environment;
  final String expiration;
  final String spaceId;
  final String clientIp;
  final String clientIpCountry;
  final String serverTime;
  final String sessionId;
  final String sessionKey;

  static const fromMapFactory = _$fromMap;

  Map<String, dynamic> toMap() {
    return {
      'platformType': platformType,
      'ticket': ticket,
      'profileId': profileId,
      'userId': userId,
      'nameOnPlatform': nameOnPlatform,
      'environment': environment,
      'expiration': expiration,
      'spaceId': spaceId,
      'clientIp': clientIp,
      'clientIpCountry': clientIpCountry,
      'serverTime': serverTime,
      'sessionId': sessionId,
      'sessionKey': sessionKey,
    };
  }

  factory UbiLoginDto.fromMap(Map<String, dynamic> map) {
    return UbiLoginDto(
      platformType: map['platformType'],
      ticket: map['ticket'],
      profileId: map['profileId'],
      userId: map['userId'],
      nameOnPlatform: map['nameOnPlatform'],
      environment: map['environment'],
      expiration: map['expiration'],
      spaceId: map['spaceId'],
      clientIp: map['clientIp'],
      clientIpCountry: map['clientIpCountry'],
      serverTime: map['serverTime'],
      sessionId: map['sessionId'],
      sessionKey: map['sessionKey'],
    );
  }
}

UbiLoginDto _$fromMap(Map<String, dynamic> map) => UbiLoginDto.fromMap(map);
