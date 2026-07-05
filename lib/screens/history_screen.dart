import 'package:flutter/material.dart';
import 'package:fruit_store_app/models/fruit_model.dart';
import 'package:fruit_store_app/models/cart_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<OrderHistory> _orders = [];
  String _selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    _loadOrderHistory();
  }

  void _loadOrderHistory() {
    final fruits = Fruit.getFruits();
    _orders = [
      OrderHistory(
        id: 'ORD-001',
        items: [
          CartItem(fruit: fruits[0], quantity: 2),
          CartItem(fruit: fruits[3], quantity: 1),
        ],
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        totalAmount: 85000,
        status: 'Selesai',
      ),
      OrderHistory(
        id: 'ORD-002',
        items: [
          CartItem(fruit: fruits[2], quantity: 3),
          CartItem(fruit: fruits[4], quantity: 1),
        ],
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        totalAmount: 100000,
        status: 'Dalam Pengiriman',
      ),
      OrderHistory(
        id: 'ORD-003',
        items: [
          CartItem(fruit: fruits[1], quantity: 1),
        ],
        orderDate: DateTime.now().subtract(const Duration(days: 10)),
        totalAmount: 15000,
        status: 'Selesai',
      ),
    ];
  }

  List<OrderHistory> get _filteredOrders {
    if (_selectedFilter == 'Semua') return _orders;
    return _orders.where((order) => order.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History Pemesanan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('Semua', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Selesai', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Dalam Pengiriman', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Dibatalkan', false),
                ],
              ),
            ),
          ),
          
          // Orders List
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada pesanan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mulai belanja untuk membuat pesanan',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: _getStatusColor(order.status).withOpacity(0.1),
                            child: Icon(
                              _getStatusIcon(order.status),
                              color: _getStatusColor(order.status),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.id,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_formatDate(order.orderDate)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            'Total: Rp ${order.totalAmount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order.status,
                              style: TextStyle(
                                color: _getStatusColor(order.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  ...order.items.map(
                                    (item) => ListTile(
                                      leading: Text(
                                        item.fruit.image,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      title: Text(item.fruit.name),
                                      subtitle: Text(
                                        '${item.quantity}x @ Rp ${item.fruit.price.toStringAsFixed(0)}',
                                      ),
                                      trailing: Text(
                                        'Rp ${item.totalPrice.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      dense: true,
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Pesanan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Rp ${order.totalAmount.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (order.status == 'Selesai')
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // Reorder logic
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      icon: const Icon(Icons.repeat, color: Colors.white),
                                      label: const Text(
                                        'Pesan Lagi',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: _selectedFilter == label,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      backgroundColor: Colors.grey.shade200,
      selectedColor: Colors.green.shade100,
      checkmarkColor: Colors.green,
      labelStyle: TextStyle(
        color: _selectedFilter == label ? Colors.green : Colors.grey.shade700,
        fontWeight: _selectedFilter == label ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: _selectedFilter == label ? Colors.green : Colors.transparent,
          width: 1,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Dalam Pengiriman':
        return Colors.orange;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Selesai':
        return Icons.check_circle;
      case 'Dalam Pengiriman':
        return Icons.local_shipping;
      case 'Dibatalkan':
        return Icons.cancel;
      default:
        return Icons.circle;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}