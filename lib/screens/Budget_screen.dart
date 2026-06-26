import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen>
    with SingleTickerProviderStateMixin {
  final _budgetController = TextEditingController();
  final _expenceController = TextEditingController();
  double _currentBudget = 0.0;
  double _spentAmount = 0.0;
  double _remainingAmount = 0.0;

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _budgetController.dispose();
    _expenceController.dispose();
    super.dispose();
  }

  void _setBudget() {
    final newBudget = double.tryParse(_budgetController.text) ?? 0.0;
    if (newBudget > 0) {
      _currentBudget = newBudget;
      _updateRemainingBudget();
      _budgetController.clear();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(
        content: const Text('Budget set Successfully!'),
        backgroundColor: const Color(0xFF1C1C3A),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid budget amount!'),
          backgroundColor: const Color(0xFFFF416C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _addExpense() {
    final expense = double.tryParse(_expenceController.text) ?? 0.0;
    if (expense > 0 && expense <= _remainingAmount) {
      _spentAmount += expense;
      _updateRemainingBudget();
      _expenceController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Expense added successfully!'),
          backgroundColor: const Color(0xFF1C1C3A),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid expense amount or insufficient budget!'),
          backgroundColor: const Color(0xFFFF416C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _updateRemainingBudget() {
    setState(() {
      _remainingAmount = _currentBudget - _spentAmount;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Budget',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D2B), Color(0xFF1A1A4E), Color(0xFF2D1B6B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                elevation: 20,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: const Color(0xFF1C1C3A),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Manage Your Monthly Budget',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF7971E),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Set limits and track spending',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      TextField(
                        controller: _budgetController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Enter Your Budget Amount',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.wallet, color: Color(0xFFF7971E)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFF7971E), width: 2),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF252547),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _setBudget,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF7971E),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFFF7971E).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),

                        child: const Text(
                          'Set Budget',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoCard(
                        icon: Icons.wallet,
                        iconColor: const Color(0xFFF7971E),
                        title: 'Current Budget:',
                        value: '\$${_currentBudget.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.money_off,
                        iconColor: const Color(0xFFFF416C),
                        title: 'Spent Amount:',
                        value: '\$${_spentAmount.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.money,
                        iconColor: const Color(0xFF38EF7D),
                        title: 'Remaining Amount:',
                        value: '\$${_remainingAmount.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 28),
                      TextField(
                        controller: _expenceController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Enter Expence Amount',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.money, color: Color(0xFFFF416C)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFFF416C), width: 2),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF252547),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _addExpense,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF416C),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFFFF416C).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Add Expense',
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
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF252547),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF3D3D6B), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white54, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
