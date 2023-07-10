import 'package:database_app/db/my_database.dart';
import 'package:database_app/model/database_model.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController code = TextEditingController();

  Future<MainModel>? result;

  void sendModelToData() async {
    final MainModel model = MainModel(
      fName: fname.text,
      lName: lname.text,
      code: int.parse(code.text),
    );
    result = MainDataBase.instance.sendData(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60.0,
                    width: 300.0,
                    child: TextFormField(
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
                        labelText: "First name",
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
                        labelText: "Last name",
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
                      maxLength: 3,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        labelText: "Code",
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          sendModelToData();
                        });
                      }
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300.0,
                    width: 300.0,
                    child: Center(
                      child: FutureBuilder(
                        future: result,
                        builder: (BuildContext context,
                            AsyncSnapshot<MainModel> snapshot) {
                          if (!(snapshot.hasData)) {
                            return const SizedBox();
                          }
                          return result == null
                              ? const Text(
                                  "Faild",
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                )
                              : const Text(
                                  "Successful",
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
