import 'package:flutter/material.dart';
import 'package:cointrack2/entities_list.dart';
import 'package:cointrack2/repository/entityRepo.dart';

import 'model/entity.dart';

class UpdateEntity extends StatefulWidget {
  EntityRepo repo;
  Entity entity;
  int position;

  UpdateEntity(this.repo, this.entity, this.position, {Key? key})
      : super(key: key);

  @override
  State<UpdateEntity> createState() => _UpdateEntity(repo, entity, position);
}

class _UpdateEntity extends State<UpdateEntity> {
  EntityRepo repo;
  Entity entity;
  int position;

  late String _name;
  late String _category;
  late int _sum;
  late String _details;
  late DateTime _date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _UpdateEntity(this.repo, this.entity, this.position) {
    _name = entity.name;
    _category = entity.category;
    _sum = entity.sum;
    _details = entity.details;
    _date = entity.date;
  }

  Widget _buildNameField() {
    return TextFormField(
      initialValue: _name,
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
      },
      onChanged: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      initialValue: _category,
      decoration: const InputDecoration(labelText: 'Category'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Category is required';
        }
      },
      onChanged: (String? value) {
        _category = value!;
      },
    );
  }

  Widget _buildSumField() {
    return TextFormField(
      initialValue: _sum.toString(),
      decoration: const InputDecoration(labelText: 'Company number'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Company nr is required';
        }
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
      initialValue: _details,
      decoration: const InputDecoration(labelText: 'Details'),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Details is required';
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
        appBar: AppBar(
          title: const Text('Update entity'),
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
                  children: [
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
                  onPressed: () {
                    //setState(() {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    //_formKey.currentState!.save();
                    Entity entity = Entity(repo.entities.length, _name, _category,
                        _sum, _details, _date);

                    repo.update(entity, position);

                    //Navigator.of(context).pop();
                    Navigator.pop(context, entity);

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
                  child: const Text('Update Entry'),
                ),
              ])),
        ));
  }
}
