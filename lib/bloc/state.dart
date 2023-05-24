import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  //textfielddan kiritilgan infolar shu titleListga qo'shib boriladi.
  List<String>? titleList;

  //bu statusni ko'rsatish uchun
  final TodoStatus status;

  TodoState({
    this.titleList,
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({List<String>? titleList, TodoStatus? status}) {
    return TodoState(
      titleList: titleList ?? this.titleList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        titleList,
        status,
      ];
}

enum TodoStatus { initial, success, error, loading }
