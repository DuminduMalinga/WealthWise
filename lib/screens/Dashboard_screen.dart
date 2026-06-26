import 'package:first_project/screens/Goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Income_screen.dart';
import 'Expence_screen.dart';
import 'Investments_screen.dart';
import 'Meetings_screen.dart';
import 'Budget_screen.dart';
import 'Profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0D2B), Color(0xFF1A1A4E), Color(0xFF2D1B6B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Welcome 👋',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage your finances with ease',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Daily Planner',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C63FF),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  //shrinkWrap: true,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: EdgeInsets.zero,
                  shrinkWrap: false,

                  children: [
                    _buildDashboardCard(
                      context,
                      title: 'Expenses',
                      icon: Icons.money_off,
                      gradientColors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ExpenseScreen()),
                      ),
                    ),
                    _buildDashboardCard(
                      context,
                      title: 'Income',
                      icon: Icons.attach_money,
                      gradientColors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => IncomeScreen()),
                      ),
                    ),
                    _buildDashboardCard(
                      context,
                      title: 'Investments',
                      icon: Icons.trending_up,
                      gradientColors: [Color(0xFF2193B0), Color(0xFF6DD5ED)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => InvestmentScreen()),
                      ),
                    ),
                    _buildDashboardCard(
                      context,
                      title: 'Meetings',
                      icon: Icons.group,
                      gradientColors: [Color(0xFF834D9B), Color(0xFFD04ED6)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MeetingsScreen()),
                      ),
                    ),
                    _buildDashboardCard(
                      context,
                      title: 'Budget',
                      icon: Icons.account_balance_wallet,
                      gradientColors: [Color(0xFFF7971E), Color(0xFFFFD200)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BudgetScreen()),
                      ),
                    ),
                    _buildDashboardCard(
                      context,
                      title: 'Goal',
                      icon: FontAwesomeIcons.bullseye,
                      gradientColors: [Color(0xFFFF6B6B), Color(0xFFFFA500)],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => GoalScreen()),
                      ),
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

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white24,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
