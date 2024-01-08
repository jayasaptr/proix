import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesproix/cubit/activity/activity_cubit.dart';
import 'package:tesproix/pages/home_page.dart';

class AddHeaderPage extends StatelessWidget {
  const AddHeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add Header',
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
        child: Column(
          children: [
            TextFormField(
              controller: ActivityCubit.codeController,
              decoration: const InputDecoration(
                labelText: 'Code',
              ),
            ),
            TextFormField(
              controller: ActivityCubit.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<ActivityCubit, ActivityState>(
              listener: (context, state) {
                if (state is HeaderCreated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Header Created'),
                    ),
                  );
                  Navigator.pop(context);
                }
                if (state is HeaderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      context.read<ActivityCubit>().createHeader(
                          ActivityCubit.codeController.text,
                          ActivityCubit.nameController.text);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
