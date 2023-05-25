import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class AddTodoEvent extends TodoEvent {
  //user kiritgan info textfield orqali
  final String title;

  AddTodoEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

class DeleteTodoEvent extends TodoEvent {
  final int index;

  DeleteTodoEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class UpdateTodoEvent extends TodoEvent {
  final int index;
  final String title;

  UpdateTodoEvent({
    required this.index,
    required this.title,
  });

  @override
  List<Object?> get props => [
        index,
        title,
      ];
}
