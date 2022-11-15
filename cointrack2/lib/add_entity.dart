import 'package:flutter/material.dart';
import 'package:cointrack2/entities_list.dart';
import 'package:cointrack2/repository/entityRepo.dart';

import 'model/entity.dart';

class AddEntity extends StatefulWidget {
  EntityRepo repo;

  AddEntity(this.repo, {Key? key}) : super(key: key);

  @override
  State<AddEntity> createState() => _AddEntity(repo);
}

class _AddEntity extends State<AddEntity> {
  EntityRepo repo;

  _AddEntity(this.repo);

  late String _name;
  late String _category;
  late int _sum = 0;
  late String _details;
  DateTime _date = DateTime.now();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
      onChanged: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: ''),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Category is required';
        }
        return null;
      },
      onChanged: (String? value) {
        _category = value!;
      },
    );
  }

  Widget _buildSumField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Sum'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Sum is required';
        }
        if (int.tryParse(value) == null) {
          return 'Sum must be an integer';
        }
        return null;
      },
      onChanged: (String? value) {
        if (int.tryParse(value!) != null) {
          _sum = int.parse(value);
        }
      },
    );
  }

  Widget _buildDetailsField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Details'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          _details = "";
        }
      },
      onChanged: (String? value) {
        _details = value!;
      },
    );
  }

  Future<void> _buildDateField(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2030));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFd9dde8),
        appBar: AppBar(
          title: const Text('Add entity'),
        ),
        body: Container(
          margin: const EdgeInsets.all(50),
          alignment: Alignment.center,
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                _buildNameField(),
                _buildCategoryField(),
                _buildSumField(),
                _buildDetailsField(),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => _buildDateField(context),
                      icon: const Icon(Icons.calendar_month),
                      splashRadius: 20,
                    ),
                    Text('${_date.day}-${_date.month}-${_date.year}'),
                  ],
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color?>(Colors.deepPurple[200]),
                  ),
                  onPressed: () {
                    //setState(() {
                    //notify that the internal state of obj has changed (repo)

                    if (!_formKey.currentState!.validate()) return;

                    //_formKey.currentState!.save();

                    repo.add(Entity(repo.entities.length, _name, _category,
                        _sum, _details, _date));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => EntitiesList(repo)));
                    //});

                    Navigator.pushAndRemoveUntil<Entity>(
                      context,
                      MaterialPageRoute<Entity>(
                        builder: (BuildContext context) => EntitiesList(repo),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('Save Entry'),
                ),
              ])),
        ));
  }
}
