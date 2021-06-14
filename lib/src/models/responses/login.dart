import 'dart:convert';

class LoginResponse {
  final String platformType;
  final String ticket;

  LoginResponse({
    required this.platformType, 
    required this.ticket, 
  });

  LoginResponse copyWith({
    String? platformType,
    String? ticket,
  }) {
    return LoginResponse(
      platformType: platformType ?? this.platformType,
      ticket: ticket ?? this.ticket,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platformType': platformType,
      'ticket': ticket,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      platformType: map['platformType'],
      ticket: map['ticket'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source));

  @override
  String toString() => 'LoginResponse(platformType: $platformType, ticket: $ticket)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginResponse &&
      other.platformType == platformType &&
      other.ticket == ticket;
  }

  @override
  int get hashCode => platformType.hashCode ^ ticket.hashCode;
}
