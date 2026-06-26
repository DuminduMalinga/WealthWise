import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen>
    with SingleTickerProviderStateMixin {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedIncomeType;
  DateTime? selectedDate;

  final List<String> incomeTypes = [
    'Salary',
    'Real Estate',
    'Part Time',
    'Other',
  ];

  late AnimationController _controller;
  late Animation<double> _fadeanimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeanimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    amountController.dispose();
    super.dispose();
  }

  void resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      selectedIncomeType = null;
      selectedDate = null;
    });
    amountController.clear();
    descriptionController.clear();
  }

  void saveIncome() {
    if (selectedIncomeType == null ||
        amountController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Income saved:\n'
          'Type: $selectedIncomeType\n'
          'Amount: ${amountController.text}\n'
          'Date: $formattedDate',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetForm();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF38EF7D))),
          ),
        ],
      ),
    );
  }

  void pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF38EF7D),
              onPrimary: Colors.black,
              surface: Color(0xFF1C1C3A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Color(0xFF0D0D2B)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // ScaffoldMessenger.of(context).showSnackBar(
  //   SnackBar(
  //     content: Text(
  //       'Income saved:\nType: $selectedIncomeType\nAmount: ${amountController.text}\nDate: $formattedDate',
  //     ),
  //   ),
  // );

  //   setState(() {
  //     selectedIncomeType = null;
  //     amountController.clear();
  //     selectedDate = null;
  //   });
  // }

  InputDecoration _fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: const Color(0xFF38EF7D)),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF3D3D6B)),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF38EF7D), width: 2),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      filled: true,
      fillColor: const Color(0xFF252547),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Add Income',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Track Your Income Source Here')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D2B), Color(0xFF1A1A4E), Color(0xFF11312D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeanimation,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: const Color(0xFF1C1C3A),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.attach_money, color: Color(0xFF38EF7D), size: 28),
                          SizedBox(width: 8),
                          Text(
                            'Add Your Income',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF38EF7D),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      DropdownButtonFormField<String>(
                        value: selectedIncomeType,
                        hint: const Text('Select Income Type', style: TextStyle(color: Colors.white54)),
                        dropdownColor: const Color(0xFF252547),
                        style: const TextStyle(color: Colors.white),
                        items: incomeTypes.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Color(0xFF38EF7D),
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(type),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIncomeType = value;
                          });
                        },
                        decoration: _fieldDecoration('Income Type', Icons.category),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: _fieldDecoration('Amount', Icons.attach_money),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: pickDate,
                        child: InputDecorator(
                          decoration: _fieldDecoration('Date', Icons.calendar_today),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate != null
                                    ? DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(selectedDate!)
                                    : 'Select a date',
                                style: TextStyle(
                                  color: selectedDate != null
                                      ? Colors.white
                                      : Colors.white38,
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down, color: Colors.white38),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _fieldDecoration('Description (optional)', Icons.note).copyWith(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF3D3D6B)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF38EF7D), width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: saveIncome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38EF7D),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(double.infinity, 52),
                          elevation: 6,
                          shadowColor: const Color(0xFF38EF7D).withOpacity(0.4),
                        ),
                        child: const Text(
                          'Save Income',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
