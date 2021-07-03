import 'package:r6api/r6api.dart';

void main() async {
  final api = R6Api(email: 'YOUR-EMAIL', password: 'YOUR-PASSWORD');
  final serverStatus = await api.getStatus();
  final profilByUsername = await api.getByUsername(Platform.uplay, 'Godly');
  final profilById = await api.getById(Platform.uplay, 'be3313d6-d443-4eae-818f-bb7f56837781');
  final playtime = await api.getPlaytime(Platform.uplay, 'be3313d6-d443-4eae-818f-bb7f56837781');
}