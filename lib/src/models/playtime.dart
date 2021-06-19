class Playtime {
  Playtime({
    required this.id,
    required this.pvp,
    required this.pve,
  });
  final String id;
  final Pvp pvp;
  final Pve pve;
}

class Pvp {
  Pvp({
    required this.general,
    required this.ranked,
    required this.casual,
    required this.custom,
    required this.other,
  });

  final int general;
  final int ranked;
  final int casual;
  final int custom;
  final int other;
}

class Pve {
  Pve({
    required this.general,
  });

  final int general;
}
