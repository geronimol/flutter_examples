class ChampionPlayer {
  final String name;
  final int totalGrandSlams;

  ChampionPlayer({ required this.name, required this.totalGrandSlams });

  @override
  String toString() {
    return name;
  }
}