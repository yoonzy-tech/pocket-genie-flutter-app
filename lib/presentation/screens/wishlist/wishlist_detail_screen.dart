import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_genie/presentation/screens/wishlist/add_wishlist_screen.dart';
import 'package:pocket_genie/presentation/screens/wishlist/item_detail_screen.dart';

// Models
class WishItem {
  final String id;
  final String title;
  final String addedBy;
  final bool isCompleted;
  final String? location;

  WishItem({
    required this.id,
    required this.title,
    required this.addedBy,
    this.isCompleted = false,
    this.location,
  });
}

// Providers - In a real app, these would connect to Firebase
final selectedWishlistProvider = Provider<WishList>((ref) {
  return WishList(
    id: '3',
    title: 'Korea Trip with Alex',
    itemCount: 15,
    completedCount: 0,
  );
});

final wishlistItemsProvider = Provider<List<WishItem>>((ref) {
  return [
    WishItem(
      id: '1',
      title: 'Try 제육볶음 in Seoul',
      addedBy: 'You',
      location: 'Seoul, South Korea',
    ),
    WishItem(
      id: '2',
      title: 'Bike along Han River',
      addedBy: 'Alex',
      location: 'Seoul, South Korea',
    ),
    WishItem(
      id: '3',
      title: 'Visit Busan beaches',
      addedBy: 'Jamie',
      location: 'Busan, South Korea',
    ),
  ];
});

class WishList {
  final String id;
  final String title;
  final int itemCount;
  final int completedCount;
  final List<String>? sharedWith;

  WishList({
    required this.id,
    required this.title,
    required this.itemCount,
    required this.completedCount,
    this.sharedWith,
  });
}

class WishListDetailScreen extends ConsumerWidget {
  const WishListDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(selectedWishlistProvider);
    final items = ref.watch(wishlistItemsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          wishlist.title,
          style: const TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show list options
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shared with section
                if (wishlist.sharedWith != null && wishlist.sharedWith!.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24.0 : 16.0,
                    ),
                    child: Chip(
                      backgroundColor: const Color(0xFFE5E5E5),
                      label: Text(
                        'Shared with: ${wishlist.sharedWith!.join(", ")}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ),

                // Action buttons
                Padding(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Item'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddWishItemScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB347), // Gold Amber
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.map),
                          label: const Text('Show Map'),
                          onPressed: () {
                            // Navigate to map view
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF4285F4), // Wish Blue
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: Color(0xFF4285F4)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Items list
                Expanded(
                  child: items.isEmpty
                      ? const Center(
                    child: Text(
                      'No items yet. Add your first wish!',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 16,
                      ),
                    ),
                  )
                      : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 24.0 : 16.0,
                    ),
                    child: isTablet
                        ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return WishItemCard(
                          item: items[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WishItemDetailScreen(item: items[index]),
                              ),
                            );
                          },
                        );
                      },
                    )
                        : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return WishItemCard(
                          item: items[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WishItemDetailScreen(item: items[index]),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFFB347), // Gold Amber
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}

class WishItemCard extends StatelessWidget {
  final WishItem item;
  final VoidCallback onTap;

  const WishItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF999999),
                  width: 2,
                ),
                color: item.isCompleted ? const Color(0xFF22C55E) : Colors.transparent,
              ),
              child: item.isCompleted
                  ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
                  : null,
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                      decoration: item.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Added by: ${item.addedBy}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Options menu
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Color(0xFF666666),
              ),
              onPressed: () {
                // Show item options
              },
            ),
          ],
        ),
      ),
    );
  }
}