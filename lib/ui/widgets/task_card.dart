import 'package:flutter/material.dart';
import 'package:tasked/cubit/task_cubit.dart';
import 'package:tasked/models/task_model.dart';
import 'package:tasked/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the button
      Widget yesButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () async {
            context.read<TaskCubit>().deleteTask(task);
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: blackTextStyle,
          ));

      Widget noButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: greyTextStyle,
          ));
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text(
          "Delete this task?",
          style: blackTextStyle.copyWith(fontSize: 15),
        ),
        actions: [yesButton, noButton],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return GestureDetector(
      onTap: () {
        print('object');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          // height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 1.0,
              ),
            ],
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),
            // border: Border.all(color: primaryColor)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: blackTextStyle.copyWith(
                          fontSize: 25, fontWeight: medium),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: redColor,
                      ))
                ],
              ),
              Divider(thickness: 2, color: primaryColor),
              Text(
                task.note,
                style:
                    greyTextStyle.copyWith(fontSize: 15, fontWeight: regular),
              )
            ],
          ),
        ),
      ),
    );
  }
}
