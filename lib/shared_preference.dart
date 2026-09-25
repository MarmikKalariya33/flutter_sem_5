import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class shared extends StatefulWidget {
  const shared({super.key});

  @override
  State<shared> createState() => _sharedState();
}

class _sharedState extends State<shared> {
  final nameCtr = TextEditingController();

  String gender = "M";
  bool agree = false;

  List<Map<String, dynamic>> item = [];

  static const key = 'entries';

  Future<void> load() async {
    final pref = await SharedPreferences.getInstance();
    final raw = pref.getString(key);

    if (raw == null) return;

    final list = jsonDecode(raw) as List;

    setState(() {
      item = list.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    nameCtr.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (nameCtr.text.trim().isEmpty) return;

    item.add({
      'name': nameCtr.text,
      'gender': gender,
      'agree': agree,
    });

    final pref = await SharedPreferences.getInstance();

    await pref.setString(key, jsonEncode(item));

    nameCtr.clear();

    setState(() {
      gender = "M";
      agree = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtr,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            // Male
            RadioListTile<String>(
              title: const Text('Male'),
              value: "M",
              groupValue: gender,
              onChanged: (v) {
                setState(() {
                  gender = v!;
                });
              },
            ),

            // Female
            RadioListTile<String>(
              title: const Text('Female'),
              value: "F",
              groupValue: gender,
              onChanged: (v) {
                setState(() {
                  gender = v!;
                });
              },
            ),

            // I Agree
            CheckboxListTile(
              title: const Text('I Agree'),
              value: agree,
              onChanged: (v) {
                setState(() {
                  agree = v!;
                });
              },
            ),

            const SizedBox(height: 10),

            // Save Button
            ElevatedButton(
              onPressed: save,
              child: const Text('Save'),
            ),

            const SizedBox(height: 10),

            // Saved Data
            Expanded(
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  final data = item[index];

                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text(
                        'Gender: ${data['gender'] == "M" ? "Male" : "Female"}\n'
                            'Agree: ${data['agree'] ? "Yes" : "No"}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}