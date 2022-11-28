import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:project1/Provider/provider_todo.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import 'addtask_screen.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Consumer(
          builder: (context, TransactionProvider provider, child) {
            int count = provider.transactionModel.length;
            double isDoneCount = provider.getCount() / count;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Hero(
                    tag: 'work',
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: const Icon(
                        Icons.work,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  provider.transactionModel.isEmpty
                      ? '0 Tasks'
                      : '$count Tasks',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Works',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LinearPercentIndicator(
                  lineHeight: 2,
                  percent: provider.transactionModel.isEmpty
                      ? 0
                      : provider.getPercent(),
                  progressColor: Colors.blue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  provider.transactionModel.isEmpty
                      ? '0% to completed'
                      : '${(isDoneCount * 100).toStringAsFixed(0)} % to completed',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: provider.transactionModel.isEmpty
                      ? const Center(
                          child: Text(
                            'Add your first task!',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Container(
                          height: 100,
                          padding: const EdgeInsets.all(0),
                          child: ListView.builder(
                            itemCount: provider.transactionModel.length,
                            itemBuilder: (context, index) {
                              List<TransactionModel> data =
                                  provider.transactionModel;

                              return provider.transactionModel.isEmpty
                                  ? Container()
                                  : Dismissible(
                                      key: UniqueKey(),
                                      background: const Card(
                                        color: Colors.red,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Swipe to remove task,',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        provider.removeTransaction(index);
                                      },
                                      child: ListTile(
                                        leading: Checkbox(
                                          value: data[index].value,
                                          onChanged: (value) {
                                            provider.onChecked(index, value!);
                                          },
                                        ),
                                        title: Text(data[index].title),
                                      ),
                                    );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTask(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
