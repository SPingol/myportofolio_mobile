import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506637136";
  final String nama = "Serafin Reysetyo Amantresno Grajo Pingol";
  final String kelas = "PBP KKI";

  final List<ItemHomepage> items = [
    ItemHomepage(
      "View Projects",
      Icons.folder,
      const Color(0xFFFF6A00),
    ), // Active Selection Orange
    ItemHomepage(
      "Add Project",
      Icons.add_circle,
      const Color(0xFF262B34),
    ), // Hangar Gunmetal Slate
    ItemHomepage(
      "Logout",
      Icons.logout,
      const Color(0xFF9B1C1C),
    ), // Sortie Abort Crimson
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0C0E),
      appBar: AppBar(
        title: const Text(
          'MYPORTFOLIO',
          style: TextStyle(
            color: Color(0xFFFF6A00),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        backgroundColor: const Color(0xFF12151A),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(color: const Color(0xFFFF6A00), height: 2.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Horizontal row showing 3 InfoCards.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Greeting and 3-column action grid.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Welcome to MyPortfolio Mobile!',
                      style: TextStyle(
                        color: Color(0xFFF3F4F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF14171D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: Color(0x99FF6A00), width: 1.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFFFF6A00),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFFE5E7EB)),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: Color(0x4DFFFFFF), width: 1.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFF14171D),
                content: Text(
                  "You pressed the ${item.name} button!",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
