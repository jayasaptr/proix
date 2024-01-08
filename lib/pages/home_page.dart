import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesproix/cubit/activity/activity_cubit.dart';
import 'package:tesproix/pages/add_detail_page.dart';
import 'package:tesproix/pages/add_header_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ActivityCubit>().getHeader();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Indexim Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is HeaderError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is HeaderCreated) {
            context.read<ActivityCubit>().getHeader();
          }
          if (state is GetHeader) {
            //cek apakah list kosong
            if (state.header.isEmpty) {
              return const Center(
                child: Text("Data Kosong"),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.header.length,
              itemBuilder: (context, index) {
                final header = state.header[index];
                //cek apakah list kosong
                return Card(
                  child: ListTile(
                    title: Text(header.name ?? ""),
                    subtitle: Text(header.code ?? ""),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddActivityPage(headerModel: header),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddHeaderPage(),
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
