import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;
  final String note;

  TaskModel({required this.title, required this.note, this.id = ''});

  factory TaskModel.fromJson(String id, Map<String, dynamic> json) =>
      TaskModel(id: id, title: json['title'], note: json['note']);

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, note];
}
