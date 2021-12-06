import 'package:flutter/material.dart';
import 'package:tasked/cubit/task_cubit.dart';
import 'package:tasked/models/task_model.dart';
import 'package:tasked/shared/theme.dart';
import 'package:tasked/ui/pages/write_task_page.dart';
import 'package:tasked/ui/widgets/task_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TaskCubit>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Do your task,",
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: light),
          ),
          Text(
            "with TASKED",
            style: blackTextStyle.copyWith(fontSize: 30, fontWeight: semiBold),
          )
        ],
      );
    }

    Widget taskList() {
      return BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (state is TaskSuccess) {
            if (state.tasks.length == 0) {
              return Center(
                child: Text(
                  'No task for us...',
                  style: greyTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: state.tasks.map((TaskModel tasks) {
                    return TaskCard(task: tasks);
                  }).toList(),
                ),
              );
            }
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget addTaskButton() {
      return Container(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: blackColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WriteTaskPage()));
            },
            child: Text(
              "+ Add Task",
              style:
                  whiteTextStyle.copyWith(fontSize: 25, fontWeight: semiBold),
            )),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [header(), taskList()],
            ),
          ),
        ),
      ),
      floatingActionButton: addTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
