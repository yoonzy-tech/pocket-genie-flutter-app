// Sample data providers - in a real app, these would connect to Firebase
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_genie/domain/entities/wishlist.dart';

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
      title: 'Korea Trip with Ruby',
      itemCount: 15,
      completedCount: 0,
    ),
  ];
});
