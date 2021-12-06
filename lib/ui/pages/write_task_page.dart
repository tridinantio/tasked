import 'package:flutter/material.dart';
import 'package:tasked/cubit/task_cubit.dart';
import 'package:tasked/models/task_model.dart';
import 'package:tasked/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteTaskPage extends StatefulWidget {
  const WriteTaskPage({Key? key}) : super(key: key);

  @override
  State<WriteTaskPage> createState() => _WriteTaskPageState();
}

class _WriteTaskPageState extends State<WriteTaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false];
    Widget saveTaskButton() {
      return Container(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: blackColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              if (taskController.text.isEmpty || titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: redColor,
                    content: Text('Empty task is a no-no...')));
              } else {
                TaskModel task = TaskModel(
                    title: titleController.text, note: taskController.text);
                context.read<TaskCubit>().createTask(task);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: greenColor,
                    content: Text('Yeay!Task added successfully!')));
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "Save Task",
              style:
                  whiteTextStyle.copyWith(fontSize: 25, fontWeight: semiBold),
            )),
      );
    }

    Widget buttonToggle() {
      return Row(
        children: [
          ToggleButtons(children: [Text('Urgent')], isSelected: isSelected)
        ],
      );
    }

    Widget textArea() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        height: 600,
        margin: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20)),
        child: Scrollbar(
          child: TextField(
            controller: taskController,
            cursorColor: primaryColor,
            style: blackTextStyle.copyWith(fontSize: 20),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 1,
            maxLines: 90,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: "Write your task here.",
                hintStyle: greyTextStyle),
          ),
        ),
      );
    }

    Widget titleField() {
      return Container(
        child: TextFormField(
          controller: titleController,
          cursorColor: primaryColor,
          minLines: 1,
          maxLines: 10,
          style: blackTextStyle.copyWith(fontSize: 30),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              hintStyle: greyTextStyle),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  titleField(),
                  textArea(),
                  // buttonToggle()
                ],
              ),
            ),
          )),
      floatingActionButton: saveTaskButton(),
    );
  }
}
