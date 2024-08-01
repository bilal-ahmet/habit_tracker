import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_databse.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:habit_tracker/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    // read exisiting habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
  }

  final TextEditingController textController = TextEditingController();

  //  create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "create a new habit"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //  get the new habit name
              String newHabitName = textController.text;

              // save to db
              context.read<HabitDatabase>().addHabbit(newHabitName);

              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
      ),
      body: buildHabitList(),
    );
  }

  Widget buildHabitList(){
    
    //  habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //  current habit
    List<Habit> currentHabits = habitDatabase.currentHabbits;

    //  return list of habit UI
    return ListView.builder(itemCount: currentHabits.length, itemBuilder: (context, index) {
      
      //  get each individual habit
      final habit = currentHabits[index];

      //  chech if the habit is completed today
      bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

      //  return habit tile UI
      return ListTile(
        title: Text(habit.name),
      );
    },);
  }
}
