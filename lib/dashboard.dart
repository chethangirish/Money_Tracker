import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Dashboard Page
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  List<Map<String, dynamic>> _allTransactions = [
    {
      "id": "1",
      "title": "Lunch in Office",
      "subtitle": "Cash . 21 Aug 2025",
      "amount": "-₹230",
      "color": Colors.red,
      "icon": "assets/Food logo.svg"
    },
    {
      "id": "2",
      "title": "Travel",
      "subtitle": "Online . 21 Aug 2025",
      "amount": "-₹40",
      "color": Colors.red,
      "icon": "assets/Travel icon.svg"
    },
    {
      "id": "3",
      "title": "Rent",
      "subtitle": "Online . 21 Aug 2025",
      "amount": "-₹3000",
      "color": Colors.red,
      "icon": "assets/Rent Icon.svg"
    },
    {
      "id": "4",
      "title": "Salary",
      "subtitle": "Online . 21 Aug 2025",
      "amount": "+₹23000",
      "color": Colors.green,
      "icon": "assets/Salary Icon.svg"
    }
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_searchQuery.isEmpty) return _allTransactions;
    return _allTransactions.where((transaction) {
      return transaction["title"]
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismiss by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout from your account?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    switch (index) {
      case 0:
        // Dashboard - stay on current page
        break;
      case 1:
        // Navigate to Analytics
        Navigator.pushNamed(context, '/analytics');
        break;
      case 2:
        // Show logout dialog
        _showLogoutDialog();
        break;
    }
  }

  void _deleteTransaction(String transactionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Delete Transaction',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete this transaction?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _allTransactions.removeWhere((t) => t["id"] == transactionId);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transaction deleted successfully'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _editTransaction(Map<String, dynamic> transaction) {
    final titleController = TextEditingController(text: transaction["title"]);
    final amountController = TextEditingController(
        text: transaction["amount"]
            .toString()
            .replaceAll('₹', '')
            .replaceAll('+', '')
            .replaceAll('-', ''));
    String selectedType =
        transaction["amount"].toString().startsWith('+') ? 'Income' : 'Expense';
    String selectedCategory = _getCategoryFromIcon(transaction["icon"]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              title: const Text(
                'Edit Transaction',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      items: ['Income', 'Expense'].map((value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (newValue) {
                        setDialogState(() => selectedType = newValue!);
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      items: ['Food', 'Travel', 'Rent', 'Salary', 'Other']
                          .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                          .toList(),
                      onChanged: (newValue) {
                        setDialogState(() => selectedCategory = newValue!);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      setState(() {
                        final index =
                            _allTransactions.indexWhere((t) => t["id"] == transaction["id"]);
                        if (index != -1) {
                          _allTransactions[index] = {
                            "id": transaction["id"],
                            "title": titleController.text,
                            "subtitle": transaction["subtitle"],
                            "amount":
                                "${selectedType == 'Income' ? '+' : '-'}₹${amountController.text}",
                            "color":
                                selectedType == 'Income' ? Colors.green : Colors.red,
                            "icon": _getIconFromCategory(selectedCategory),
                          };
                        }
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transaction updated successfully'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.green)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addTransaction() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = 'Expense';
    String selectedCategory = 'Food';
    String selectedPaymentMethod = 'Cash';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                'Add New Transaction',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Transaction Title',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Amount (₹)',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Transaction Type',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      items: ['Income', 'Expense'].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setDialogState(() {
                          selectedType = newValue!;
                          // Auto-adjust category based on type
                          if (selectedType == 'Income') {
                            selectedCategory = 'Salary';
                          } else {
                            selectedCategory = 'Food';
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      items: ['Food', 'Travel', 'Rent', 'Salary', 'Other']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setDialogState(() => selectedCategory = newValue!);
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedPaymentMethod,
                      dropdownColor: const Color(0xFF1E1E1E),
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Payment Method',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      items: ['Cash', 'Online', 'Card', 'UPI']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setDialogState(() => selectedPaymentMethod = newValue!);
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty &&
                        amountController.text.trim().isNotEmpty) {
                      // Validate amount is a valid number
                      final amount = double.tryParse(amountController.text.trim());
                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid amount'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      // Generate new transaction
                      final newTransaction = {
                        "id": DateTime.now().millisecondsSinceEpoch.toString(),
                        "title": titleController.text.trim(),
                        "subtitle": "$selectedPaymentMethod . ${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
                        "amount": "${selectedType == 'Income' ? '+' : '-'}₹${amountController.text.trim()}",
                        "color": selectedType == 'Income' ? Colors.green : Colors.red,
                        "icon": _getIconFromCategory(selectedCategory),
                      };

                      setState(() {
                        _allTransactions.insert(0, newTransaction); // Add to top of list
                      });

                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${selectedType == 'Income' ? 'Income' : 'Expense'} added successfully'),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all required fields'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  String _getCategoryFromIcon(String iconPath) {
    if (iconPath.contains('Food')) return 'Food';
    if (iconPath.contains('Travel')) return 'Travel';
    if (iconPath.contains('Rent')) return 'Rent';
    if (iconPath.contains('Salary')) return 'Salary';
    return 'Other';
  }

  String _getIconFromCategory(String category) {
    switch (category) {
      case 'Food':
        return 'assets/Food logo.svg';
      case 'Travel':
        return 'assets/Travel icon.svg';
      case 'Rent':
        return 'assets/Rent Icon.svg';
      case 'Salary':
        return 'assets/Salary Icon.svg';
      default:
        return 'assets/Food logo.svg';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Row
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      "assets/profile.svg",
                      height: screenWidth * 0.07,
                      width: screenWidth * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    "John",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              /// Balance and Spending
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _infoCard("Balance", "₹1200.37", screenWidth)),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(child: _infoCard("Total Spending", "₹5000", screenWidth)),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  Expanded(child: _infoCard("Incoming", "₹2500", screenWidth)),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(child: _infoCard("Outgoing", "₹2500", screenWidth)),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              /// Recent Transactions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transactions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.006,
                        horizontal: screenWidth * 0.04,
                      ),
                    ),
                    onPressed: _addTransaction, // Call the add transaction function
                    icon: Icon(Icons.add, color: Colors.green, size: screenWidth * 0.05),
                    label: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.04),
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.012),

              /// Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF141414),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.04,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.05),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: screenWidth * 0.12,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey, size: screenWidth * 0.05),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged("");
                            },
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              /// Total Spending Text
              Text(
                "Total Spending: ₹5000",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.015),

              /// Transactions List
              Expanded(
                child: _filteredTransactions.isEmpty && _searchQuery.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              color: Colors.grey,
                              size: screenWidth * 0.12,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "No transactions found",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            Text(
                              "Try searching with different keywords",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = _filteredTransactions[index];
                          return TransactionTile(
                            transaction: transaction,
                            screenWidth: screenWidth,
                            onEdit: () => _editTransaction(transaction),
                            onDelete: () => _deleteTransaction(transaction["id"]),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/window.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.grey),
            activeIcon: SvgPicture.asset("assets/window.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.green),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/graph.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.grey),
            activeIcon: SvgPicture.asset("assets/graph.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.green),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/logout.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.grey),
            activeIcon: SvgPicture.asset("assets/logout.svg",
                height: screenWidth * 0.06, width: screenWidth * 0.06, color: Colors.green),
            label: "",
          ),
        ],
      ),
    );
  }

  static Widget _infoCard(String title, String value, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.035),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// TransactionTile widget with clickable edit & delete
class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final double screenWidth;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.screenWidth,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
      child: ListTile(
        leading: SvgPicture.asset(
          transaction["icon"],
          height: screenWidth * 0.08,
          width: screenWidth * 0.08,
          color: Colors.white,
        ),
        title: Text(
          transaction["title"],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        subtitle: Text(
          transaction["subtitle"],
          style: TextStyle(
            color: Colors.grey,
            fontSize: screenWidth * 0.035,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              transaction["amount"],
              style: TextStyle(
                color: transaction["color"],
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            GestureDetector(
              onTap: onEdit,
              child: SvgPicture.asset(
                'assets/Edit icon.svg',
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            GestureDetector(
              onTap: onDelete,
              child: SvgPicture.asset(
                'assets/delete.svg',
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}