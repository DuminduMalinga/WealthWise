import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expectedReturnController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'stocks';
  String _selectedStatus = 'Active';
  DateTime? _investmentDate;

  late AnimationController _controller;
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
    _amountController.dispose();
    _expectedReturnController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      //_selectedType = null;
      _investmentDate = null;
    });
    _amountController.clear();
    _expectedReturnController.clear();
  }

  void _saveInvestment() {
    double? amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0 || _investmentDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all required fields with valid values!'),
          backgroundColor: const Color(0xFFFF416C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C3A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Investment saved:\n'
          'Type: $_selectedType\n'
          'Amount: ${_amountController.text}\n'
          'Expected Return: ${_expectedReturnController.text.isEmpty ? "N/A" : _expectedReturnController.text}\n'
          'Date: ${_investmentDate!.year}-${_investmentDate!.month.toString().padLeft(2, '0')}-${_investmentDate!.day.toString().padLeft(2, '0')}\n'
          'Status: $_selectedStatus',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetForm();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF6DD5ED))),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6DD5ED),
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
      setState(() => _investmentDate = picked);
    }
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    Color iconColor = const Color(0xFF6DD5ED),
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: iconColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF3D3D6B)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: iconColor, width: 2),
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
        title: Text(
          'Track Investments',
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
                          'Add Investment Details',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6DD5ED),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Track and manage your portfolio',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      DropdownButtonFormField<String>(
                        value: _selectedType,
                        dropdownColor: const Color(0xFF1C1C3A),
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration(
                          label: 'Investment Type',
                          icon: Icons.trending_up,
                          iconColor: const Color(0xFF38EF7D),
                        ),
                        items: ['stocks', 'Real Estate', 'Mutual Funds', 'Bonds']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => setState(() => _selectedType = val!),
                      ),

                      const SizedBox(height: 16),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration(
                          label: 'Amount Invested',
                          icon: FontAwesomeIcons.moneyBill,
                          iconColor: const Color(0xFF38EF7D),
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: _buildInputDecoration(
                            label: 'Date of Investment',
                            icon: Icons.date_range,
                            iconColor: const Color(0xFF6DD5ED),
                          ),
                          child: Text(
                            _investmentDate == null
                                ? 'Select Date'
                                : '${_investmentDate!.year}-${_investmentDate!.month.toString().padLeft(2, '0')}-${_investmentDate!.day.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: _investmentDate == null
                                  ? Colors.white38
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _expectedReturnController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration(
                          label: 'Expected Return (optional)',
                          icon: Icons.percent,
                          iconColor: const Color(0xFFF7971E),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        dropdownColor: const Color(0xFF1C1C3A),
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration(
                          label: 'Status',
                          icon: Icons.info,
                          iconColor: const Color(0xFF6C63FF),
                        ),
                        items: ['Active', 'Closed', 'Pending']
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedStatus = val!),
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: _saveInvestment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2193B0),
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: const Color(0xFF2193B0).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Save Investment',
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
}
