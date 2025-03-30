import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_genie/presentation/providers/wishlist_providers.dart';
import 'package:pocket_genie/presentation/screens/home/widgets/wishlist_card.dart';
import 'package:pocket_genie/presentation/screens/wishlist/add_item_screen.dart';
import 'package:pocket_genie/presentation/screens/wishlist/add_wishlist_screen.dart';
import 'package:pocket_genie/presentation/screens/wishlist/wishlist_detail_screen.dart';
import 'package:pocket_genie/presentation/widgets/section_header.dart';


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
                  title: const Text(
                    "Ruby's Lists",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 18,
                      child: Icon(Icons.person, color: Colors.grey[500]),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add_box_outlined, color: Color(0xFF333333)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateListScreen(),
                          ),
                        );
                      },
                    ),
                  ],
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WishListDetailScreen(
                                        // wishList: myLists[index],
                                      ),
                                    ),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WishListDetailScreen(
                                        // wishList: myLists[index],
                                      ),
                                    ),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WishListDetailScreen(
                                        // wishList: myLists[index],
                                      ),
                                    ),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WishListDetailScreen(
                                        // wishList: myLists[index],
                                      ),
                                    ),
                                  );
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
