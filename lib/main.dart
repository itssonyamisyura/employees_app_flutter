import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employees App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState is the state class for HomeScreen, managing the state of the employee list and input fields.
class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  List<Map<String, dynamic>> employees = [];
  final String apiUrl = 'http://127.0.0.1:8000/employees';

  String searchTerm = '';
  String filter = 'all';

  Future<void> fetchEmployees() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        employees = data.map((item) {
          return {
            'id': item['id'],
            'name': item['name'],
            'salary': item['salary'],
            'highlighted': item['highlighted'],
          };
        }).toList();
      });
    }
  }

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      final name = employee['name'].toString().toLowerCase();
      final salary = employee['salary'] as int;
      final highlighted = employee['highlighted'] as bool;

      final matchesSearch = name.contains(searchTerm.toLowerCase());

      if (!matchesSearch) {
        return false;
      }

      if (filter == 'promotion') {
        return highlighted;
      }

      if (filter == 'salary') {
        return salary > 1000;
      }

      return true;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 900,
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                // HEADER
                Container(
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: const Color(0xff3f5f8a),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Employee Management System',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 16),

                      Text(
                        'Total employees: ${employees.length}',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Receiving a bonus: ${employees.where((employee) => employee['highlighted'] == true).length}',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: const Color(0xff3f5f8a),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchTerm = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search employee...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                filter = 'all';
                              });
                            },
                            child: const Text('All employees'),
                          ),

                          const SizedBox(width: 12),

                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                            ),

                            onPressed: () {
                              setState(() {
                                filter = 'promotion';
                              });
                            },

                            child: const Text('For promotion'),
                          ),

                          const SizedBox(width: 12),

                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                            ),

                            onPressed: () {
                              setState(() {
                                filter = 'salary';
                              });
                            },

                            child: const Text('Salary over \$1000'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                ...filteredEmployees.map((employee) {
                  return employeeItem(
                    onDelete: () async {
                      await http.delete(Uri.parse('$apiUrl/${employee['id']}'));

                      await fetchEmployees();
                    },
                    name: employee['name'],
                    salary: '\$${employee['salary']}',
                    highlighted: employee['highlighted'],

                    onToggleStar: () async {
                      await http.put(
                        Uri.parse('$apiUrl/${employee['id']}/toggle'),
                      );

                      await fetchEmployees();
                    },
                  );
                }),
                Container(
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: const Color(0xff3f5f8a),
                    borderRadius: BorderRadius.circular(8),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Add a New Employee',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter employee name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: TextField(
                              controller: salaryController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter salary in \$',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          ElevatedButton(
                            onPressed: () async {
                              final name = nameController.text;
                              final salary = int.parse(salaryController.text);

                              await http.post(
                                Uri.parse(apiUrl),
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({
                                  'name': name,
                                  'salary': salary,
                                  'highlighted': false,
                                }),
                              );

                              nameController.clear();
                              salaryController.clear();

                              fetchEmployees();
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget employeeItem({
    required String name,
    required String salary,
    bool highlighted = false,
    required VoidCallback onToggleStar,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),

      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24,
                color: highlighted ? Colors.orange : Colors.black,
              ),
            ),
          ),

          Text(
            salary,
            style: TextStyle(
              fontSize: 24,
              color: highlighted ? Colors.orange : Colors.black,
            ),
          ),

          const SizedBox(width: 24),

          IconButton(
            onPressed: onToggleStar,
            icon: const Icon(Icons.star, color: Colors.orange),
          ),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
