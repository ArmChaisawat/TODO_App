import 'package:flutter/material.dart';
import 'package:project1/Provider/Provider.dart';
import 'package:project1/models/Transaction.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final titlecontrollor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'What tasks are you planning tp platform?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your text.';
                    }
                    return null;
                  },
                  controller: titlecontrollor,
                  decoration: const InputDecoration(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          var title = titlecontrollor.text;
          Transaction statement = Transaction(title: title);
          TransactionProvider provider = Provider.of(context, listen: false);

          if (_formKey.currentState!.validate()) {
            provider.addTransaction(statement);
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 170,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
