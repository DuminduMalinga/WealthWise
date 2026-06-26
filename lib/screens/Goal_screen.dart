import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen>
    with SingleTickerProviderStateMixin {
  final _goalNameController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _contributionController = TextEditingController();
  double _currentAmount = 0.0;
  double _targetAmount = 0.0;
  double _progress = 0.0;

  late final AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
    _goalNameController.dispose();
    _targetAmountController.dispose();
    _contributionController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _setGoal() {
    double target = double.tryParse(_targetAmountController.text) ?? 0.0;
    if (_goalNameController.text.isEmpty || target <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields with valid Values!'),
          backgroundColor: const Color(0xFFFF416C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _targetAmount = target;
      _updateProgress();
    });
    _goalNameController.clear();
    _targetAmountController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
      content: const Text('Goal set Successfully!'),
      backgroundColor: const Color(0xFF1C1C3A),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _addContribution(double amount) {
    if (amount > 0 && _currentAmount + amount <= _targetAmount) {
      setState(() {
        _currentAmount += amount;
        _updateProgress();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(
        content: const Text('Contribution added!'),
        backgroundColor: const Color(0xFF1C1C3A),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid contribution amount!'),
          backgroundColor: const Color(0xFFFF416C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _updateProgress() {
    if (_targetAmount > 0) {
      _progress = (_currentAmount / _targetAmount) * 100;
    } else {
      _progress = 0.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Set Your Goals',
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Set Your Savings or\nInvestments Goals',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF6B6B),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Track progress towards your targets',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _goalNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Goal Name',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.flag, color: Color(0xFFFF6B6B)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF252547),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _targetAmountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Target Amount',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: Icon(
                            FontAwesomeIcons.bullseye,
                            color: const Color(0xFFFFA500),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFFFFA500), width: 2),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF252547),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _setGoal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B6B),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFFFF6B6B).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Set Goal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoCard(
                        icon: Icons.flag,
                        iconColor: const Color(0xFFFF6B6B),
                        title: _goalNameController.text.isEmpty
                            ? 'No Goal Set'
                            : _goalNameController.text,
                        value: 'Target: \$${_targetAmount.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 10),
                      _buildInfoCard(
                        icon: Icons.money,
                        iconColor: const Color(0xFF38EF7D),
                        title: 'Current Amount',
                        value: '\$${_currentAmount.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _progress / 100,
                          backgroundColor: const Color(0xFF252547),
                          color: const Color(0xFF38EF7D),
                          minHeight: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Progress: ${_progress.toStringAsFixed(2)}%',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF38EF7D),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _contributionController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Add Contribution',
                          labelStyle: const TextStyle(color: Colors.white54),
                          prefixIcon: const Icon(Icons.add, color: Color(0xFF6C63FF)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF252547),
                        ),
                        onSubmitted: (value) {
                          _addContribution(double.tryParse(value) ?? 0.0);
                          _contributionController.clear();
                        },
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
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
