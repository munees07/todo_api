import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map<String, dynamic> item;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Card(
          color: Colors.deepPurple[300],
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(item['title'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            subtitle: Text(item['description'],
                style: const TextStyle(color: Colors.white)),
            trailing: PopupMenuButton(
              color: Colors.white,
              onSelected: (value) {
                if (value == 'edit') {
                  //edit page
                  onEdit();
                } else if (value == 'delete') {
                  //delete page
                  onDelete();
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ];
              },
            ),
          ),
        ),
      ],
    );
  }
}
