import 'package:flutter/material.dart';
import 'package:cointrack2/repository/entityRepo.dart';
import 'package:cointrack2/update_entity.dart';

import 'add_entity.dart';
import 'model/entity.dart';

class EntitiesList extends StatefulWidget {
  final EntityRepo repo;

  const EntitiesList(this.repo, {Key? key}) : super(key: key);

  @override
  State<EntitiesList> createState() => _EntitiesListState(repo);
}

class _EntitiesListState extends State<EntitiesList> {
  EntityRepo repo;

  _EntitiesListState(this.repo);

  void _delete(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('DELETE ENTRY'),
            content: const Text('Are you sure you want to delete the selected entry?'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      repo.entities.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
            ],
          );
        });
  }

  Future<void> _navigateAndUpdate(BuildContext context, int index) async {
  //   final entity = await Navigator.pushAndRemoveUntil<Entity>(
  //     context,
  //     MaterialPageRoute<Entity>(
  //       builder: (BuildContext context) => UpdateEntity(repo, repo.entities[index], index),
  //     ),
  //         (Route<dynamic> route) => false,
  //   );
    final entity = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UpdateEntity(repo, repo.entities[index], index)));
    setState(() {
      repo.update(entity!, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(0xFFd9dde8),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: const Center(child: Text('CoinTrack'))
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: Column(children: [
          ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () => _navigateAndUpdate(context, index),
                onLongPress:() => _delete(context, index),
                title: Row(
                  children: [
                    Text((repo.entities[index].name)),
                  ],
                ),
                // trailing: Wrap(
                //   children: <Widget>[
                //     // GestureDetector(
                //     //     onLongPress:() => _delete(context, index),
                //     // ),
                //     IconButton(
                //       onPressed: () => _navigateAndUpdate(context, index),
                //       icon: const Icon(Icons.edit),
                //       splashRadius: 15,
                //     ),
                //     IconButton(
                //       onPressed: () => _delete(context, index),
                //       icon: const Icon(Icons.delete),
                //       splashRadius: 15,
                //     )
                //   ],
                // ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 10),
            itemCount: repo.entities.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddEntity(repo)));
          // Navigator.pushAndRemoveUntil<void>(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => AddEntity(repo),
          //   ),
          //       (Route<dynamic> route) => false,
          // );
        },
        backgroundColor: Colors.deepPurple[200],
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
