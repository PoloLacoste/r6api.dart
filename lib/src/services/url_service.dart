import '../constants/constants.dart';
import '../constants/urls.dart';
import '../constants/api_fields.dart';

class UrlService {
  String getAvatar(String id, [int size = 256]) =>
      '$avatars_url/$id/default_${size == 500 ? 'tall' : '${size}_$size'}.png';

  String getLogin() => _getUbiServicesURL(3, 'profiles/sessions');

  String getByUsername(Platform platform, List<String> usernames) =>
      _getUbiServicesURL(
          3, 'profiles', 'platformType=${platform.name}&namesOnPlatform=${usernames.join(',')}');

  String getByUserId(List<String> ids) =>
      _getUbiServicesURL(3, 'profiles', 'userIds=${ids.join(',')}');

  String getByProfileId(List<String> ids) =>
      _getUbiServicesURL(3, 'profiles', 'profileIds=${ids.join(',')}');

  String getByIdOnPlatform(Platform platform, List<String> ids) =>
      _getUbiServicesURL(3, 'profiles',
          'platformType=${platform.name}&idsOnPlatform=${ids.join(',')}');

  String getPlaytime(Platform platform, List<String> ids) =>
      _getUbiServicesPlatformURL(platform, 'playerstats2/statistics',
          'populations=${ids.join(',')}&statistics=${playtime_fields.join(',')}');

  String getProgress(Platform platform, List<String> ids) =>
      _getUbiServicesPlatformURL(
          platform,
          'r6playerprofile/playerprofile/progressions',
          'profile_ids=${ids.join(',')}');

  String getRanks(Platform platform, List<String> ids, String season,
          String region, String board) =>
      _getUbiServicesPlatformURL(platform, 'r6karma/players',
          'board_id=$board&profile_ids=$ids&region_id=$region&season_id=$season');

  String getStats(Platform platform, List<String> ids, String stats) =>
      _getUbiServicesPlatformURL(platform, 'playerstats2/statistics',
          'populations=${ids.join(',')}&statistics=$stats');

  String getStatus() => '$status_url/v1/instances';

  String getValidateUsername(String userId) =>
      _getUbiServicesURL(3, 'profiles/$userId/validateUpdate');

  String _getUbiServicesURL(int version, String pathname, [String? search]) =>
      '$ubiservices_url/v$version/$pathname${search != null ? '?$search' : ''}';

  String _getUbiServicesPlatformURL(
          Platform platform, String pathname, String? search) =>
      '$ubiservices_url/v1/spaces/${space_ids[platform]}'
      '/sandboxes/${sandboxes[platform]}/$pathname${search != null ? '?$search' : ''}';
}
