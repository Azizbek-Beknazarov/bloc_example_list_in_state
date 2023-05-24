import 'dart:async';

import 'package:bloc_task_sample/bloc/event.dart';
import 'package:bloc_task_sample/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<AddTodoEvent>(_addHandler);
  }

  FutureOr<void> _addHandler(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) {
    //infolar olingunga qadar CircularProgressIndicator ishlab turadi.
    emit(state.copyWith(status: TodoStatus.loading));

    // bu listga state da mavjud bo'lgan eski infolarni qo'shamiz, agar info bo'lmasa  bo'sh turadi mana bunaqa [].
    List<String> list = state.titleList ?? [];

    //yangi kiritilgan info qo'shib boriladi.
    list.add(event.title);

    //emit orqali statega to'liq list uzatiladi. va state holati success ga o'zgaradi.
    emit(state.copyWith(status: TodoStatus.success, titleList: list));
  }
}
