import 'package:flutter/material.dart';
import 'get_open_router_response.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Bot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Finance Suggestion Bot  '),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController salaryController = TextEditingController(); //this is the object which controls the text field
  TextEditingController expenseController = TextEditingController();
  String suggestion = "";
  String salary = "";
  String expense = "";


  @override
  void dispose() {
    salaryController.dispose();
    expenseController.dispose();
    super.dispose();
  }

  void _talkToGPT() async {
    final salaryInput = salaryController.text.trim();
    final expenseInput = expenseController.text.trim();

    // Optional: validate input
    if (salaryInput.isEmpty || expenseInput.isEmpty) {
      setState(() {
        suggestion = "Please enter both salary and expense.";
      });
      return;
    }

    // Call your API with both values
    String theSuggestion = await getOpenRouterResponse(salaryInput, expenseInput);

    // Update the state with the API response
    setState(() {
      suggestion = theSuggestion;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'AI',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: salaryController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'Total Salary',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: expenseController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'Total Expenses',
                ),
              ),
              SizedBox(height: 10.0),
          Text(
            suggestion,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _talkToGPT,
        tooltip: 'Talk to GPT',
        child: const Icon(Icons.send),
      ),
      
    );
  }
}
