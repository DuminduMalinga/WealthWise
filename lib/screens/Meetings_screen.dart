import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingsScreen extends StatefulWidget {
  const MeetingsScreen({super.key});

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  void resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      meetingName = null;
      meetingDate = null;
      meetingTime = null;
      venue = null;
      link = null;
      isOnline = false;
    });
  }

  String? meetingName;
  DateTime? meetingDate;
  TimeOfDay? meetingTime;
  String? venue;
  String? link;
  bool isOnline = false;

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
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: meetingDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD04ED6),
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
        meetingDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: meetingTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFD04ED6),
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
        meetingTime = picked;
      });
    }
  }

  String getFormattedDate() {
    if (meetingDate == null) return 'Select Date';
    return '${meetingDate!.year}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}';
  }

  String getFormattedTime() {
    if (meetingTime == null) return 'Select Time';
    final hour = meetingTime!.hourOfPeriod.toString().padLeft(2, '0');
    final minute = meetingTime!.minute.toString().padLeft(2, '0');
    final period = meetingTime!.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    Color iconColor = const Color(0xFFD04ED6),
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54, fontWeight: FontWeight.w500),
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
          'Organize Meetings',
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
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: const Color(0xFF1C1C3A),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Center(
                          child: Text(
                            'Plan Your Upcoming Meeting',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFD04ED6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Schedule and organize with ease',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: _buildInputDecoration(
                            label: 'Meeting Name',
                            icon: FontAwesomeIcons.handshake,
                          ),
                          onSaved: (val) => meetingName = val,
                          validator: (val) => val == null || val.isEmpty
                              ? 'Enter meeting name'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _pickDate,
                                icon: const Icon(Icons.calendar_today, size: 18),
                                label: Text(
                                  getFormattedDate(),
                                  style: const TextStyle(fontSize: 13),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF834D9B),
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _pickTime,
                                icon: const Icon(Icons.access_time, size: 18),
                                label: Text(
                                  getFormattedTime(),
                                  style: const TextStyle(fontSize: 13),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF834D9B),
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) => states.contains(WidgetState.selected)
                                        ? const Color(0xFFD04ED6)
                                        : const Color(0xFF252547),
                                  ),
                                  checkColor: WidgetStateProperty.all(Colors.white),
                                  side: const BorderSide(color: Color(0xFF3D3D6B), width: 2),
                                ),
                              ),
                              child: Checkbox(
                                value: isOnline,
                                onChanged: (val) {
                                  setState(() {
                                    isOnline = val ?? false;
                                  });
                                },
                              ),
                            ),
                            Text(
                              'Online Meeting',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (!isOnline)
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration(
                              label: 'Venue',
                              icon: FontAwesomeIcons.locationDot,
                              iconColor: const Color(0xFFFF6B6B),
                            ),
                            onSaved: (val) => venue = val,
                            validator: (val) {
                              if (!isOnline && (val == null || val.isEmpty)) {
                                return 'Enter venue';
                              }
                              return null;
                            },
                          ),
                        if (isOnline)
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: _buildInputDecoration(
                              label: 'Online Meeting Link',
                              icon: FontAwesomeIcons.link,
                              iconColor: const Color(0xFF6DD5ED),
                            ),
                            onSaved: (val) => link = val,
                            validator: (val) {
                              if (isOnline && (val == null || val.isEmpty)) {
                                return 'Enter meeting link';
                              }
                              return null;
                            },
                          ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if (meetingName == null ||
                                  meetingName!.isEmpty ||
                                  meetingDate == null ||
                                  meetingTime == null ||
                                  (isOnline && (link == null || link!.isEmpty)) ||
                                  (!isOnline &&
                                      (venue == null || venue!.isEmpty))) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Please fill in all required fields.',
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFFFF416C),
                                  ),
                                );
                                return;
                              }

                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: const Color(0xFF1C1C3A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Text(
                                    'Meeting Info',
                                    style: TextStyle(
                                      color: Color(0xFFD04ED6),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'Name: $meetingName\n'
                                    'Date: ${getFormattedDate()}\n'
                                    'Time: ${getFormattedTime()}\n'
                                    '${isOnline ? "Link: $link\nOnline Meeting" : "Venue: $venue\nPhysical Meeting"}',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        resetForm();
                                      },
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(color: Color(0xFFD04ED6)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF834D9B),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: const Color(0xFF834D9B).withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Save Meeting',
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
      ),
    );
  }
}
