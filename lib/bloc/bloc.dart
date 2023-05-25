import 'package:bloc_task_sample/bloc/event.dart';
import 'package:bloc_task_sample/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState(titleList: [])) {
    on<AddTodoEvent>(_addHandler);
    on<DeleteTodoEvent>(_deleteHandler);
    on<UpdateTodoEvent>(_updateHandler);
  }

  void _addHandler(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) {
    //infolar olingunga qadar CircularProgressIndicator ishlab turadi.
    emit(state.copyWith(status: TodoStatus.loading));

    // bu listga state da mavjud bo'lgan eski infolarni qo'shamiz, agar info bo'lmasa  bo'sh turadi mana bunaqa [].
    // List<String> list = state.titleList ?? [];

    //yangi kiritilgan info qo'shib boriladi.
    // list.add(event.title);

    //emit orqali statega to'liq list uzatiladi. va state holati success ga o'zgaradi.
    emit(state.copyWith(
      status: TodoStatus.success,
      titleList: [...state.titleList, event.title],
    ));
  }

  void _deleteHandler(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    emit(state.copyWith(
      status: TodoStatus.success,
      titleList: [
        for (int i = 0; i < state.titleList.length; i++)
          if (i != event.index) state.titleList[i]
      ],
    ));
  }

  void _updateHandler(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    emit(state.copyWith(
      status: TodoStatus.success,
      titleList: [
        for (int i = 0; i < state.titleList.length; i++)
          if (i == event.index) event.title else state.titleList[i]
      ],
    ));
  }
}
