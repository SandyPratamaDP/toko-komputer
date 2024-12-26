import 'package:flutter/material.dart';
import 'package:tokokomputer/detail_screen.dart';
import 'package:tokokomputer/models/laptop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Komputer'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            return const ComputerList();
          } else if (constraints.maxWidth <= 900) {
            return const ComputerGrid(gridCount: 3);
          } else if (constraints.maxWidth <= 1200) {
            return const ComputerGrid(gridCount: 4);
          } else if (constraints.maxWidth <= 1500) {
            return const ComputerGrid(gridCount: 6);
          } else {
            return const ComputerGrid(gridCount: 8);
          }
        },
      ),
    );
  }
}

class ComputerList extends StatelessWidget {
  const ComputerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listLaptop.length,
        itemBuilder: (context, index) {
          final laptop = listLaptop[index];

          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(
                  laptop: laptop,
                );
              }));
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    listLaptop[index].image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(listLaptop[index].name),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        listLaptop[index].price,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(laptop: laptop),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

class ComputerGrid extends StatelessWidget {
  final int gridCount;

  const ComputerGrid({super.key, required this.gridCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.count(
        crossAxisCount: gridCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: listLaptop.map((laptop) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(laptop: laptop);
              }));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      laptop.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            laptop.name,
                            style: const TextStyle(fontSize: 16.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            laptop.price,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
