import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_colors.dart';

void main() async {
  // Ensure binding initialized (required if you use async in main)
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables or config
  // await Env.load();

  // Initialize dependency injection/services (e.g., Hive, API clients)
  // await setupServiceLocator();

  // Set up global error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    // You can also send error logs to your backend or crash reporting
    Logger.error(details.exceptionAsString(), details.stack);
  };

  // Run the app inside a ProviderScope (for Riverpod) or any root wrapper you need
  runApp(CognivoApp());
}

// 1. Define a simple Cubit.
// This Cubit manages an integer state and starts with a value of 0.
class MyBloc extends Cubit<int> {
  MyBloc() : super(0);
}

class CognivoApp extends StatelessWidget {
  const CognivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [BlocProvider(create: (context) => MyBloc())],
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            // theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
          ),
        );
      },
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => MainScreen()),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    // Add more routes here
  ],
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _cognivoLogo(),
            SizedBox(height: 20.h),
            _cognivoButton(context),
            SizedBox(height: 20.h),
            _cognivoStats(),
          ],
        ),
      ),
    );
  }

  Widget _cognivoLogo() {
    return Image.asset('assets/cognivo_icon.png', width: 150.w, height: 150.h);
  }

  Widget _cognivoButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Start learning', style: GoogleFonts.roboto()),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Color(0xFFF5F5DC),
        shadowColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
    );
  }

  Widget _cognivoStats() {
    return Column();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: const Center(child: Text('Login functionality goes here.')),
    );
  }
}

class Logger {
  static void error(String message, StackTrace? stack) {
    developer.log(
      message,
      name: 'APP_ERROR',
      level: 1000, // Error severity
      stackTrace: stack,
    );
    // You can also add your own reporting to backend here
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customGrey,
      appBar: AppBar(
        backgroundColor: AppColors.customGrey,
        // leading: Image.asset('assets/cognivo_icon.png'),
        actions: [Icon(Icons.flip_camera_ios, color: AppColors.customGreen)],
      ),
    );
  }
}
