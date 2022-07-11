import 'package:flutter/material.dart';
import 'package:note/models/group.dart';
import 'package:note/objectbox.g.dart';
import 'package:note/view/task_screen.dart';

import 'add_group_screen.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final _groups = <Group>[];
  late final Store _store;
  late final Box<Group> _groupsBox;

  Future <void> _addGroup() async{
    final result = await showDialog(
    context: context,
    builder: (_) => const AddGroupScreen(),
    );
    if(result != null && result is Group){
      _groupsBox.put(result);
      _loadGroups();
    }
  }
  void _loadGroups(){
    _groups.clear();
    setState(() {
      _groups.addAll(_groupsBox.getAll());
    });
  }

  Future <void> _loadStore() async{
    _store = await openStore();
    _groupsBox = _store.box<Group>();
    _loadGroups();
  }

  Future<void> _goToTasks(Group group) async{
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => TasksScreen(group: group, store: _store),
      ),
    );
    _loadGroups();
  }

  @override
  void initStore(){
    _loadStore();
    super.initState();
  }

  @override
  void dispose(){
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTEList'),
      ),
      body: _groups.isEmpty
          ? const Center(
              child: Text('No tienes grupos'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
              ),
              itemCount: _groups.length,
              itemBuilder: (context, index){
                final group = _groups[index];
                return _GroupsItem(
                  onTap: ()=> _goToTasks(group),
                  group:group,
                );
              },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed:_addGroup ,
          label: const Text('Añadir grupo'),
      ),
    );
  }
}

class _GroupsItem extends StatelessWidget {
  const _GroupsItem({Key? key, required this.group, required this.onTap}) : super(key: key);

  final Group group;
  final VoidCallback onTap;



  @override
  Widget build(BuildContext context) {
    final descripcion = group.tasksDescription();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(group.color),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                group.name,
                style: const TextStyle(
                  color:  Colors.white,
                  fontSize: 22,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}






