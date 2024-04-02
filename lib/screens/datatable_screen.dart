import 'package:flutter/material.dart';
import 'package:flutter_examples/constants.dart';
import '../models/champion_player.dart';


class DataTableScreen extends StatelessWidget {
  const DataTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Table'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const DataTableWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key});

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  bool sortAscending = false;
  int sortColumnIndex = 1;
  final scrollController = ScrollController();
  List<ChampionPlayer> playersList = [], playersFilteredList =[];

  @override
  void initState() {
    loadChampionPlayersList();
    playersFilteredList = playersList;
    super.initState();
  }
  
  loadChampionPlayersList() {
    playersList.add(ChampionPlayer(name: 'Roger Federer', totalGrandSlams: 20));
    playersList.add(ChampionPlayer(name: 'Rafael Nadal', totalGrandSlams: 20));
    playersList.add(ChampionPlayer(name: 'Novak Djokovic', totalGrandSlams: 20));
    playersList.add(ChampionPlayer(name: 'Pete Sampras', totalGrandSlams: 14));
    playersList.add(ChampionPlayer(name: 'Björn Borg', totalGrandSlams: 11));
    playersList.add(ChampionPlayer(name: 'Jimmy Connors', totalGrandSlams: 8));
    playersList.add(ChampionPlayer(name: 'Ivan Lendl', totalGrandSlams: 8));
    playersList.add(ChampionPlayer(name: 'Andre Agassi', totalGrandSlams: 8));
    playersList.add(ChampionPlayer(name: 'John McEnroe', totalGrandSlams: 7));
    playersList.add(ChampionPlayer(name: 'Mats Wilander', totalGrandSlams: 7));
    playersList.sort((a, b) {
      int cmp = b.totalGrandSlams.compareTo(a.totalGrandSlams);
      if (cmp != 0) return cmp;
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    },);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const textStyleDataTableTitle = TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w600);
    const textStyleDataTableCell = TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w600);
    return Column(
      children: [
        const SizedBox(height: kDefaultPadding,),

        /// Description Text
        const Text('Updated as of 2021 US Open.', style: TextStyle(fontStyle: FontStyle.italic),),

        /// Search bar
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: TextField(
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search)
            ),
            onChanged: (s) {
              setState(() {
                playersFilteredList = playersList.where((player) => player.name.toLowerCase().contains(s.toLowerCase())).toList();
              });
            },
          ),
        ),

        /// DataTable
        Scrollbar(
          controller: scrollController,
          trackVisibility: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: DataTable(
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              columnSpacing: size.width > 350 ? null : 20,
              dataRowMaxHeight: size.width > 350 ? null : 80,
              columns: <DataColumn>[
                DataColumn(
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortColumnIndex = columnIndex;
                      sortAscending = ascending;
                    });
                    if (columnIndex == 0) {
                      if (ascending) {
                        playersFilteredList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                      } else {
                        playersFilteredList.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
                      }
                    }
                  },
                  label: const Text(
                    'Champion',
                    style: textStyleDataTableTitle,
                  ),
                ),
                DataColumn(
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      sortColumnIndex = columnIndex;
                      sortAscending = ascending;
                    });
                    if (columnIndex == 1) {
                      if (ascending) {
                        playersFilteredList.sort((a, b) {
                          int cmp = a.totalGrandSlams.compareTo(b.totalGrandSlams);
                          if (cmp != 0) return cmp;
                          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                        });
                      } else {
                        playersFilteredList.sort((a, b) {
                          int cmp = b.totalGrandSlams.compareTo(a.totalGrandSlams);
                          if (cmp != 0) return cmp;
                          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                        });
                      }
                    }
                  },
                  label: const Text(
                    'Grand Slams',
                    style: textStyleDataTableTitle,
                  ),
                ),
              ],
              rows: playersFilteredList.map((user) {
                return DataRow(cells: <DataCell>[
                  DataCell(
                    SizedBox(
                      width: size.width > 350 ? null : size.width * 0.6,
                      child: Text(user.name, style: textStyleDataTableCell,),
                    ),
                  ),
                  DataCell(
                    Text('${user.totalGrandSlams}', style: textStyleDataTableCell,),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

