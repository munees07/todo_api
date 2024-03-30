// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_api/controller/todo_provider.dart';
import 'package:todo_api/model/todo_model.dart';
import 'package:todo_api/utils/snackbar_helper.dart';

class AddScreen extends StatelessWidget {
  final Todo? todo;

  const AddScreen({Key? key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('qwert');
    final provider = Provider.of<TodoProvider>(context, listen: false);
    final TextEditingController titleController = provider.titleController;
    final TextEditingController detailsController = provider.detailsController;

    if (todo != null) {
      titleController.text = todo!.title;
      detailsController.text = todo!.description;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple[400],
        centerTitle: true,
        title: Text(
          todo != null ? 'Edit To-Do' : 'Add To-Do',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/backgroundTodo.jpg',
              fit: BoxFit.fill,
            ),
          ),
          _buildBody(context, titleController, detailsController),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, TextEditingController titleController,
      TextEditingController detailsController) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Title',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: detailsController,
            decoration: const InputDecoration(
              hintText: 'Details',
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
            ),
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () => _submit(
                  context, titleController.text, detailsController.text),
              child: Text(
                todo != null ? 'Update' : 'Submit',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(
      BuildContext context, String title, String description) async {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    if (todo != null) {
      await provider.updateTodo(todo!.id, title, description);
      successMessage(context, message: 'Todo updated successfully');
    } else {
      await provider.submitTodo(title, description);
      provider.clearControllers();
      successMessage(context, message: 'Todo added successfully');
    }
    provider.fetchTodo(context);
  }
}
