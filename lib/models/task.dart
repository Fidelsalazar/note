import 'package:objectbox/objectbox.dart';
import 'package:note/models/group.dart';

@Entity()
class Task{
  int id = 0;
  String descripcion;
  bool completed = false;

  final group = ToOne<Group>();

  Task({
    required this.descripcion,
  });
}