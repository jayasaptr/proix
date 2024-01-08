import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesproix/common/shared_code.dart';
import 'package:tesproix/cubit/activity/activity_cubit.dart';
import 'package:tesproix/model/detail_model.dart';
import 'package:tesproix/model/header_model.dart';
import 'package:tesproix/pages/home_page.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({this.headerModel, super.key});
  final HeaderModel? headerModel;

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  int? step = 0;
  String? before;
  String? after;
  DateTime? date;
  String? time;
  TextEditingController codeController = TextEditingController();
  TextEditingController actionDetailController = TextEditingController();
  TextEditingController recommendActionDetailController =
      TextEditingController();

  @override
  void initState() {
    context.read<ActivityCubit>().getDetail(widget.headerModel!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add Detail',
          style: TextStyle(color: Colors.white),
        ),
        //back
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<ActivityCubit, ActivityState>(
          listener: (context, state) {
            if (state is DetailCreated) {
              //show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Detail Created'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false);
            }
          },
          builder: (context, state) {
            return BlocBuilder<ActivityCubit, ActivityState>(
              builder: (context, state) {
                return Stepper(
                    onStepContinue: () {
                      if (state is ActivityStepPage) {
                        if (state.step == 2) {
                          context.read<ActivityCubit>().createDetail(
                              code: codeController.text,
                              date: date,
                              time: time,
                              before: before,
                              action: actionDetailController.text,
                              after: after,
                              recommendAction:
                                  recommendActionDetailController.text,
                              headerId: widget.headerModel!.id!);
                        } else {
                          context
                              .read<ActivityCubit>()
                              .activityStepPage(state.step + 1);
                        }
                      }
                    },
                    onStepTapped: (step) {
                      context.read<ActivityCubit>().activityStepPage(step);
                    },
                    type: StepperType.horizontal,
                    steps: state is GetDetail
                        ? steps(context, state.detail)
                        : steps(context, null),
                    currentStep: state is ActivityStepPage ? state.step : 0,
                    onStepCancel: () {
                      if (state is ActivityStepPage) {
                        if (state.step == 0) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        } else {
                          context
                              .read<ActivityCubit>()
                              .activityStepPage(state.step - 1);
                        }
                      }
                    });
              },
            );
          },
        ),
      ),
    );
  }

  List<Step> steps(BuildContext context, DetailModel? detailModel) {
    if (detailModel != null) {
      codeController.text = detailModel.code!;
      date = detailModel.date;
      time = detailModel.time;
      before = detailModel.before;
      actionDetailController.text = detailModel.action!;
      after = detailModel.after;
      recommendActionDetailController.text = detailModel.recommendAction!;
    }
    return [
      Step(
        title: const Text(''),
        content: Column(
          children: [
            TextFormField(
              controller: codeController,
              decoration: const InputDecoration(labelText: 'Code'),
            ),
            //date picker
            DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'dd/MM/yyyy',
              controller: null,
              //date 2024-01-08 00:00:00.000 to initial value
              initialValue: date != null
                  ? "${date!.day}/${date!.month}/${date!.year}"
                  : null,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: const Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              //use24HourFormat: false,
              //locale: Locale('pt', 'BR'),
              onChanged: (val) => {
                setState(() {
                  date = DateTime.parse(val);
                })
              },
            ),
            DateTimePicker(
              type: DateTimePickerType.time,
              dateMask: 'dd/MM/yyyy',
              controller: null,
              initialValue: time,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: const Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              //use24HourFormat: false,
              //locale: Locale('pt', 'BR'),
              onChanged: (val) => {
                setState(() {
                  time = val;
                })
              },
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text(''),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Before",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Future<File?> imageFile = SharedCode.addImage(
                  source: ImageSource.camera,
                );

                imageFile.then((value) {
                  if (value != null) {
                    setState(() {
                      ActivityCubit.beforeDetailController = value.path;
                      before = value.path;
                    });
                  }
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: before != null
                    ? Image.file(
                        File(before!),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: actionDetailController,
              decoration: const InputDecoration(labelText: 'Action'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text(''),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "After",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Future<File?> imageFile = SharedCode.addImage(
                  source: ImageSource.camera,
                );

                imageFile.then((value) {
                  if (value != null) {
                    setState(() {
                      ActivityCubit.afterDetailController = value.path;
                      after = value.path;
                    });
                  }
                });
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: after != null
                    ? Image.file(
                        File(after!),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: recommendActionDetailController,
              decoration: const InputDecoration(labelText: 'Recomendation'),
            ),
          ],
        ),
        isActive: true,
      ),
    ];
  }
}
