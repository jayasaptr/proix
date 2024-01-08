import 'package:flutter/material.dart';
import 'package:tesproix/cubit/activity/activity_cubit.dart';
import 'package:tesproix/pages/home_page.dart';
import 'injection.dart' as git;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  git.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => git.locator<ActivityCubit>(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GlobalLoaderOverlay(
            overlayColor: Colors.black.withOpacity(0.4),
            useDefaultLoading: true,
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Indexim",
              home: HomePage(),
            ),
          );
        },
      ),
    );
  }
}
