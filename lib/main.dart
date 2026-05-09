import 'package:flutter/material.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      body: Center(
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

                child: const Column(
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
                      'Total employees: 3',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Receiving a bonus: 1',
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
                          onPressed: () {},
                          child: const Text('All employees'),
                        ),

                        const SizedBox(width: 12),

                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),

                          onPressed: () {},

                          child: const Text('For promotion'),
                        ),

                        const SizedBox(width: 12),

                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),

                          onPressed: () {},

                          child: const Text('Salary over \$1000'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              employeeItem(name: 'John H.', salary: '\$800'),

              employeeItem(
                name: 'Alex M.',
                salary: '\$3000',
                highlighted: true,
              ),

              employeeItem(name: 'Carla W.', salary: '\$5000'),
              const SizedBox(height: 24),

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
                          onPressed: () {},
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
    );
  }

  Widget employeeItem({
    required String name,
    required String salary,
    bool highlighted = false,
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
            onPressed: () {},
            icon: const Icon(Icons.star, color: Colors.orange),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
