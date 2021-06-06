import '../models/board.dart';

enum Platform { uplay, psn, xbl }
enum PlatformAll { uplay, psn, xbl, steam, epic, amazon }

final boards = {
  'pvp_ranked': Board(
    id: 'pvp_ranked',
    name: 'Ranked',
    seasonId: 6,
  ),
  'pvp_newcomer': Board(
    id: 'pvp_newcomer',
    name: 'Newcomer',
    seasonId: 12,
  ),
  'pvp_casual': Board(
    id: 'pvp_casual',
    name: 'Casual',
    seasonId: 15,
  ),
  'pvp_event': Board(
    id: 'pvp_event',
    name: 'Event',
    seasonId: 16,
  ),
};

const space_ids = {
  Platform.uplay: '5172a557-50b5-4665-b7db-e3f2e8c5041d',
  Platform.psn: '05bfb3f7-6c21-4c42-be1f-97a33fb5cf66',
  Platform.xbl: '98a601e5-ca91-4440-b1c5-753f601a2c90'
};
const sandboxes = {
  Platform.uplay: 'OSBOR_PC_LNCH_A',
  Platform.psn: 'OSBOR_PS4_LNCH_A',
  Platform.xbl: 'OSBOR_XBOXONE_LNCH_A'
};

enum Region { emea, ncsa, apac }

const regions = {
  Region.emea: 'Europe, Middle East and Africa',
  Region.ncsa: 'North, Central and South America',
  Region.apac: 'Asia Pacific'
};

// Ember Rise (15) and above
const ranks = {
  23: 'Champions',
  22: 'Diamond',
  21: 'Platinum 1',
  20: 'Platinum 2',
  19: 'Platinum 3',
  18: 'Gold 1',
  17: 'Gold 2',
  16: 'Gold 3',
  15: 'Silver 1',
  14: 'Silver 2',
  13: 'Silver 3',
  12: 'Silver 4',
  11: 'Silver 5',
  10: 'Bronze 1',
  9: 'Bronze 2',
  8: 'Bronze 3',
  7: 'Bronze 4',
  6: 'Bronze 5',
  5: 'Copper 1',
  4: 'Copper 2',
  3: 'Copper 3',
  2: 'Copper 4',
  1: 'Copper 5',
  0: 'Unranked'
};

// Phantom Sight (14) and below
const old_ranks = {
  20: 'Diamond',
  19: 'Platinum 1',
  18: 'Platinum 2',
  17: 'Platinum 3',
  16: 'Gold 1',
  15: 'Gold 2',
  14: 'Gold 3',
  13: 'Gold 4',
  12: 'Silver 1',
  11: 'Silver 2',
  10: 'Silver 3',
  9: 'Silver 4',
  8: 'Bronze 1',
  7: 'Bronze 2',
  6: 'Bronze 3',
  5: 'Bronze 4',
  4: 'Copper 1',
  3: 'Copper 2',
  2: 'Copper 3',
  1: 'Copper 4',
  0: 'Unranked'
};
