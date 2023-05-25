import 'package:bloc_task_sample/bloc/bloc.dart';
import 'package:bloc_task_sample/bloc/event.dart';
import 'package:bloc_task_sample/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task app"),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (_, state) {
        // infolar olingunga qadar loading bo'ladi.
        if (state.status == TodoStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //success bo'lsa listdagi infolarni ko'rsatamiz
        if (state.status == TodoStatus.success) {
          return ListView.builder(
              itemCount: state.titleList.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    title: Text(state.titleList[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    String name = state.titleList[index];
                                    return Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextFormField(
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                              labelText: "Name",
                                            ),
                                            initialValue: name,
                                            onChanged: (value) {
                                              name = value;
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Update"),
                                            onPressed: () {
                                              context.read<TodoBloc>().add(
                                                  UpdateTodoEvent(
                                                      index: index,
                                                      title: name));
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodoEvent(index: index));
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              });
        }
        //errorda ekranga xatolik haqida xabar chiqariladi. masalan internet ulanmagan bo'lsa
        if (state.status == TodoStatus.error) {
          return const Center(
            child: Text("Xatolik"),
          );
        }

        //boshqa har qanaqa holatda shunchaki container chiqib turaveradi.
        return Container();
      }),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (_) {
                  String? name;
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        TextButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            // event shu yerda chaqiriladi. va textfielddagi yozuvlar eventdagi title berib yuboriladi.
                            context.read<TodoBloc>().add(
                                AddTodoEvent(title: name?.trim() ?? "1111"));
                            Navigator.pop(context);
                            name = "";
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Text('Add'),
        ),
      ),
    );
  }
}
