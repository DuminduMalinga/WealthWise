import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final amountController = TextEditingController();
  String? selectedExpenseType;
  String? selectedPaymentMethod;
  DateTime? selectedDate;
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> expenseTypes = [
    'Food',
    'Travel',
    'Educational',
    'Insurance',
    'Entertainment',
    'Health',
    'Shopping',
    'Other',
  ];

  final List<String> paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'Paypal',
    'Net Banking',
  ];

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      selectedExpenseType = null;
      selectedPaymentMethod = null;
      selectedDate = null;
    });
    amountController.clear();
    descriptionController.clear();
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
              primary: Color(0xFFFF416C),
              onPrimary: Colors.white,
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

  void saveExpense() {
    if (selectedExpenseType == null ||
        amountController.text.isEmpty ||
        selectedDate == null ||
        selectedPaymentMethod == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    double? amount = double.tryParse(amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
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
          'Type: $selectedExpenseType\n'
          'Amount: ${amountController.text}\n'
          'Payment: $selectedPaymentMethod\n'
          'Date: $formattedDate',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetForm();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFFFF416C))),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: const Color(0xFFFF416C)),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF3D3D6B)),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFFF416C), width: 2),
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
          ' Add Expenses',
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
                const SnackBar(
                  content: Text('Track Your Expenses Effectively!'),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D2B), Color(0xFF1A1A4E), Color(0xFF2D1020)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

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
                        Icon(Icons.money_off, color: Color(0xFFFF416C), size: 28),
                        SizedBox(width: 8),
                        Text(
                          'Add Expense',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF416C),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: selectedExpenseType,
                      hint: const Text(
                        'Select Expense Type',
                        style: TextStyle(color: Colors.white54),
                      ),
                      dropdownColor: const Color(0xFF252547),
                      style: const TextStyle(color: Colors.white),
                      items: expenseTypes.map((Category) {
                        return DropdownMenuItem(
                          value: Category,
                          child: Text(Category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedExpenseType = value;
                        });
                      },
                      decoration: _fieldDecoration('Expense Type', Icons.category),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration('Amount', Icons.money_off),
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
                                fontSize: 15,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white38,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPaymentMethod,
                      hint: const Text(
                        'Select Payment Method',
                        style: TextStyle(color: Colors.white54),
                      ),
                      dropdownColor: const Color(0xFF252547),
                      style: const TextStyle(color: Colors.white),
                      items: paymentMethods.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value;
                        });
                      },
                      decoration: _fieldDecoration('Payment Method', Icons.payment),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration('Description (optional)', Icons.note),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: saveExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF416C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 52),
                        elevation: 6,
                        shadowColor: const Color(0xFFFF416C).withOpacity(0.4),
                      ),
                      child: const Text(
                        'Save Expense',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
    );
  }
}
