import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';
import 'UpdateTask.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> taskList = [];
  void addTask(String title, String subtitle) {
    taskList.add(Task(title: title, subTitle: subtitle));
    titleController.clear();
    subTitleController.clear();
    setState(() {});
  }

  void delete(int index) {
    taskList.removeAt(index);
    setState(() {});
  }

  void updateTodo(int index, String UpdateTitleTask, String UpdatesubTitleTask) {
    taskList[index].title = UpdateTitleTask;
    taskList[index].subTitle = UpdatesubTitleTask;
    setState(() {});
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Icon(
            Icons.search_rounded,
            color: Colors.blue,
          ),
          SizedBox(
            width: 9,
          ),
        ],
        elevation: 5,
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,top: 8,right: 8),
              child: Column(
                children: [
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter valid title';
                      }
                      return null;
                    },
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: 'Add Title',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.5),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter a valid description';
                      }
                      return null;
                    },
                    controller: subTitleController,
                    decoration: const InputDecoration(
                        hintText: 'Add description',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.5),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                if (_globalKey.currentState!.validate()) {
                  addTask(titleController.text, subTitleController.text);
                  FocusScope.of(context).unfocus();
                  setState(() {});
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text('Add'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      color: Colors.grey.shade300,
                      child: ListTile(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Alert'),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          UpdateTask(
                                            indx: index,
                                            task: taskList[index],
                                            update: updateTodo,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              delete(index);
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Delete',
                                              style: TextStyle(
                                                  color: Colors.cyan, fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              );
                        },
                        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
                        subtitleTextStyle: TextStyle(color: Colors.grey.shade800),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.red,
                        ),
                        title: Align(
                            alignment: Alignment.topLeft,
                            child: Text(taskList[index].title)),
                        subtitle: Align(
                            alignment: Alignment.topLeft,
                            child: Text(taskList[index].subTitle)),
                        trailing: const Icon(Icons.arrow_forward_sharp),
                      ),
                    );
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}