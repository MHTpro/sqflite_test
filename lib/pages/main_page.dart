import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/database_model.dart';
import 'package:database_app/pages/add_page.dart';
import 'package:database_app/pages/view_and_update.dart';
import 'package:flutter/material.dart';

class MainPageDb extends StatefulWidget {
  const MainPageDb({super.key});

  @override
  State<MainPageDb> createState() => _MainPageDbState();
}

class _MainPageDbState extends State<MainPageDb> {
  List<MainModel>? allResponse;
  bool rebuild = false;

  void autoRefresh() {
    setState(() => rebuild = true);
    MainDataBase.instance.getAll().then(
          (value) => allResponse = value,
        );
    setState(() => rebuild = false);
  }

  @override
  void initState() {
    autoRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
          autoRefresh();
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: MainDataBase.instance.getAll(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<MainModel>> snapshot) {
                if (!(snapshot.hasData)) {
                  return const CircularProgressIndicator();
                }
                return rebuild
                    ? const CircularProgressIndicator()
                    : allResponse == null || allResponse!.isEmpty
                        ? const Text(
                            "No Data",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30.0,
                            ),
                          )
                        : CustomScrollView(
                            slivers: <Widget>[
                              SliverList.builder(
                                itemCount: allResponse!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ViewUpdate(
                                            id: allResponse![index].id,
                                          ),
                                        ),
                                      );
                                      autoRefresh();
                                    },
                                    child: Draggable(
                                      childWhenDragging: const SizedBox(
                                        height: 10.0,
                                        width: 400.0,
                                      ),
                                      data: index,
                                      feedback: Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                          color: Colors.white,
                                          alignment: Alignment.center,
                                          height: 100.0,
                                          width: 100.0,
                                          child: Scaffold(
                                            backgroundColor: Colors.red,
                                            body: Center(
                                              child: Text(
                                                "Id:${allResponse![index].id}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Card(
                                        color: Colors.red,
                                        child: ListTile(
                                          title: Text(
                                            allResponse![index]
                                                .lName
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${allResponse![index].id}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              //FixedItem
                              SliverFixedExtentList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int _) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DragTarget(
                                      builder: (context, candidateData,
                                          rejectedData) {
                                        return const CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.delete,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                      onWillAccept: (Object? data) {
                                        return true;
                                      },
                                      onAccept: (Object? data) async {
                                        await MainDataBase.instance.deleteData(
                                          allResponse![data as int].id,
                                        );
                                        autoRefresh();
                                      },
                                    ),
                                  ),
                                  childCount: 1,
                                ),
                                itemExtent: 100,
                              )
                            ],
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
