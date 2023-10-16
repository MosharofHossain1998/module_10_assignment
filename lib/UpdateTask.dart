import 'package:flutter/material.dart';
import 'Task.dart';

class UpdateTask extends StatefulWidget {
  UpdateTask(
      {super.key,
        required this.task,
        required this.update,
        required this.indx});

  final Task task;
  void Function(int x, String title, String subtitle) update;
  int indx;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController titleController = TextEditingController(text: widget.task.title);
  late TextEditingController subtitleController = TextEditingController(text: widget.task.subTitle);
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Form(
                key: _globalKey,
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ),
                  child: FractionallySizedBox(
                    heightFactor: .4,
                    child: Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return 'Enter a valid title';
                                  }
                                  return null;
                                },
                                controller: titleController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 1.5),
                                    )
                                ),
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
                                controller: subtitleController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.teal, width: 1.5),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              if (_globalKey.currentState!.validate()) {
                                widget.update(widget.indx, titleController.text,
                                    subtitleController.text);


                              }
                              if (titleController.text.isNotEmpty &&
                                  subtitleController.text.isNotEmpty) {
                                Navigator.pop(context);
                              }
                              setState(() {});
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 9,horizontal: 5),
                              child: Text('Edit done',style: TextStyle(fontSize: 20),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            );
      },
      child: const Text(
        'Edit',
        style: TextStyle(color: Colors.cyan, fontSize: 18),
      ),
    );
  }
}