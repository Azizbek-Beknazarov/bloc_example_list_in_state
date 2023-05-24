import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class AddTodoEvent extends TodoEvent {
  //user kiritgan info textfield orqali
  final String title;

  AddTodoEvent({required this.title});

  @override
  List<Object?> get props => [title];
}
