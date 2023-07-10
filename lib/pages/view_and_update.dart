import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/database_model.dart';
import 'package:flutter/material.dart';

class ViewUpdate extends StatefulWidget {
  final int? id;
  const ViewUpdate({
    super.key,
    required this.id,
  });

  @override
  State<ViewUpdate> createState() => _ViewUpdateState();
}

class _ViewUpdateState extends State<ViewUpdate> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController code = TextEditingController();
  bool rebuildOn = false;
  MainModel? result;
  bool showButton = false;

  void autoRefresh() async {
    setState(
      () {
        rebuildOn = true;
      },
    );
    MainDataBase.instance.getById(widget.id).then((v) => result = v);
    setState(
      () {
        rebuildOn = false;
      },
    );
  }

  void updateTheData() async {
    final model = result!.copy(
      fName: fname.text,
      lName: lname.text,
      code: int.parse(code.text),
    );
    await MainDataBase.instance.updateData(model);
  }

  //showbuttonController
  void conditionofShowButton() {
    if (lname.text.isNotEmpty &&
        fname.text.isNotEmpty &&
        code.text.isNotEmpty) {
      setState(
        () {
          showButton = true;
        },
      );
    } else {
      setState(
        () {
          showButton = false;
        },
      );
    }
  }

  @override
  void initState() {
    autoRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: MainDataBase.instance.getById(widget.id),
            builder: (context, snapshot) {
              if (!(snapshot.hasData)) {
                return const CircularProgressIndicator();
              }
              return result == null
                  ? const Center(
                      child: Text(
                        "Can't load",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "firstName:${snapshot.data!.fName}\n\nlastName:${snapshot.data!.lName}\n\nCode:${snapshot.data!.code}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 100.0,
                            ),
                            const Text(
                              "Wanna Edit?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: fname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New fName",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: lname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New lName",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 60.0,
                              width: 300.0,
                              child: TextFormField(
                                maxLength: 3,
                                onChanged: (value) {
                                  conditionofShowButton();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Can't be empty!";
                                  }
                                  return null;
                                },
                                controller: code,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white12,
                                  labelText: "New Code",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            showButton
                                ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        updateTheData();
                                      });
                                      autoRefresh();
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
