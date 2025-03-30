import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Sample data providers - in a real app, these would connect to Firebase
final myListsProvider = Provider<List<WishList>>((ref) {
  return [
    WishList(
      id: '1',
      title: 'Travel Adventures',
      itemCount: 12,
      completedCount: 3,
    ),
    WishList(
      id: '2',
      title: 'Food Exploration',
      itemCount: 8,
      completedCount: 5,
    ),
  ];
});

final sharedListsProvider = Provider<List<WishList>>((ref) {
  return [
    WishList(
      id: '3',
      title: 'Korea Trip with Alex',
      itemCount: 15,
      completedCount: 0,
    ),
  ];
});

// Models
class WishList {
  final String id;
  final String title;
  final int itemCount;
  final int completedCount;

  WishList({
    required this.id,
    required this.title,
    required this.itemCount,
    required this.completedCount,
  });
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myLists = ref.watch(myListsProvider);
    final sharedLists = ref.watch(sharedListsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive layout handling
            final isTablet = constraints.maxWidth > 600;

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  backgroundColor: Colors.white,
                  // expandedHeight: 70,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 18,
                            child: Icon(Icons.person, color: Colors.grey[500]),
                          ),
                        ),
                        const Text(
                          "Ruby's Lists",
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: IconButton(
                            icon: const Icon(Icons.add_box_outlined, color: Color(0xFF333333)),
                            onPressed: () {
                              // Handle creating new list
                            },
                          ),
                        ),
                      ],
                    ),
                    // centerTitle: false,
                  ),
                ),

                // Content
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 24.0 : 16.0,
                    vertical: 16.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // My Lists Section
                      const SectionHeader(title: 'My Lists'),
                      const SizedBox(height: 8),

                      // Wrap in a layout builder for responsive grid or list
                      LayoutBuilder(builder: (context, constraints) {
                        if (isTablet) {
                          // Tablet: Grid layout
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.5,
                            ),
                            itemCount: myLists.length,
                            itemBuilder: (context, index) {
                              return WishListCard(
                                wishList: myLists[index],
                                onTap: () {
                                  // Navigate to list details
                                },
                              );
                            },
                          );
                        } else {
                          // Phone: List layout
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: myLists.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return WishListCard(
                                wishList: myLists[index],
                                onTap: () {
                                  // Navigate to list details
                                },
                              );
                            },
                          );
                        }
                      }),

                      const SizedBox(height: 24),

                      // Shared Lists Section
                      const SectionHeader(title: 'Shared Lists'),
                      const SizedBox(height: 8),

                      // Wrap in a layout builder for responsive grid or list
                      LayoutBuilder(builder: (context, constraints) {
                        if (isTablet) {
                          // Tablet: Grid layout
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.5,
                            ),
                            itemCount: sharedLists.length,
                            itemBuilder: (context, index) {
                              return WishListCard(
                                wishList: sharedLists[index],
                                onTap: () {
                                  // Navigate to list details
                                },
                              );
                            },
                          );
                        } else {
                          // Phone: List layout
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sharedLists.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              return WishListCard(
                                wishList: sharedLists[index],
                                onTap: () {
                                  // Navigate to list details
                                },
                              );
                            },
                          );
                        }
                      }),
                    ]),
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

// Reusable widgets
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
    );
  }
}

class WishListCard extends StatelessWidget {
  final WishList wishList;
  final VoidCallback onTap;

  const WishListCard({
    Key? key,
    required this.wishList,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    wishList.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${wishList.itemCount} items · ${wishList.completedCount} completed',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF666666),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}