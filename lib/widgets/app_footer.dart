import 'package:flutter/material.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _subscribe() {
    setState(() {
      if (_emailController.text.isEmpty) {
        _errorMessage = "Email can't be blank";
      } else if (!_isValidEmail(_emailController.text)) {
        _errorMessage = 'Email is invalid';
      } else {
        _errorMessage = null;
        // Show success message or handle subscription
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully subscribed!')),
        );
        _emailController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOpeningHours(),
                const SizedBox(height: 32),
                _buildHelpAndInfo(),
                const SizedBox(height: 32),
                _buildLatestOffers(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildOpeningHours()),
                const SizedBox(width: 32),
                Expanded(child: _buildHelpAndInfo()),
                const SizedBox(width: 32),
                Expanded(child: _buildLatestOffers()),
              ],
            ),
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Opening Hours',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '❄️ Winter Break Closure Dates ❄️',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Closing 4pm 19/12/2025',
          style: TextStyle(fontSize: 14),
        ),
        const Text(
          'Reopening 10am 05/01/2026',
          style: TextStyle(fontSize: 14),
        ),
        const Text(
          'Last post date: 12pm on 18/12/2025',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        Container(
          height: 1,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        const Text(
          '(Term Time)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Monday - Friday 10am - 4pm',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        const Text(
          '(Outside of Term Time / Consolidation Weeks)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Monday - Friday 10am - 3pm',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        const Text(
          'Purchase online 24/7',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildHelpAndInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help and Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            // Handle search navigation
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
            foregroundColor: Colors.black,
          ),
          child: const Text(
            'Search',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            // Handle terms navigation
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft,
            foregroundColor: Colors.black,
          ),
          child: const Text(
            'Terms & Conditions of Sale Policy',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLatestOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Latest offers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                ElevatedButton(
                  onPressed: _subscribe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4d2963),
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 20,
                    ),
                    minimumSize: const Size(0, 56),
                  ),
                  child: const Text('Subscribe'),
                ),
              ],
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
