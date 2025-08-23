import 'package:flutter/material.dart';
import 'package:todolist/entities/TaskStatisticsResponse.dart';
import 'package:todolist/screen/HomeScreen.dart';
import 'package:todolist/services/taskServices.dart';

class TaskStatisticsScreen extends StatefulWidget {
  const TaskStatisticsScreen({Key? key}) : super(key: key);
  @override
  State<TaskStatisticsScreen> createState() => _TaskStatisticsState();
}

class _TaskStatisticsState extends State<TaskStatisticsScreen> {
  void _handleBack(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Statistics'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _handleBack(context),
        ),
      ),
      body: FutureBuilder<TaskStatisticsResponse>(
        future: TaskService.getTaskStatistics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red)),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data!"));
          } else {
            final stats = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total task : ${stats.total}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Total completed tasks : ${stats.completed}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Total pending tasks : ${stats.pending}",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
