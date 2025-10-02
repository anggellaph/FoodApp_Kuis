// detail_page.dart
import 'package:flutter/material.dart';
import 'food.dart';

class DetailPage extends StatefulWidget {
  final FoodMenu food;

  const DetailPage({super.key, required this.food});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isButtonPressed = false;

  void _buyFood() {
    final currentContext = context;
    
    ScaffoldMessenger.of(currentContext).showSnackBar( 
      SnackBar(
        content: Text('Berhasil membeli ${widget.food.name}'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (currentContext.mounted) {
        Navigator.pop(currentContext);
      }
    });
  }

  Widget _buildFoodImage() {
    if (widget.food.imageUrls.isNotEmpty) {
      return Image.network(
        widget.food.imageUrls[0],
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.fastfood,
              size: 80,
              color: Colors.grey[600],
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    } else {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.fastfood,
          size: 80,
          color: Colors.grey[600],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildFoodImage(),
                    ),
                    
                    const SizedBox(height: 16),

                    Text(
                      widget.food.name,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            widget.food.category,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.timer, size: 16),
                        const SizedBox(width: 4),
                        Text(widget.food.cookingTime),
                      ],
                    ),
                    
                    const SizedBox(height: 16),

                    Text(
                      widget.food.price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            const Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.food.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 24),

            const Text(
              'Bahan-bahan:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: widget.food.ingredients.split(', ').map((ingredient) {
                return Chip(
                  label: Text(ingredient.trim()),
                  backgroundColor: Colors.orange[50],
                );
              }).toList(),
            ),
            
            const SizedBox(height: 40),

            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isButtonPressed ? 180 : 200,
                height: _isButtonPressed ? 55 : 60,
                child: ElevatedButton(
                  onPressed: _buyFood,
                  onHover: (isHovered) {
                    setState(() {
                      _isButtonPressed = isHovered;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: _isButtonPressed ? 2 : 4,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 8),
                      Text(
                        'Beli Sekarang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}