import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thedogapi/controller/dog_controller.dart';
import 'package:thedogapi/Cofig/shared/image_view.dart';

class FavoriteListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Danh Sách Yêu Thích'),
      // ),
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Danh Sách Yêu Thích',
            style: TextStyle(
              color: Color(0xFF8541DC),
              fontSize: 28, // Kích thước chữ lớn hơn
              fontWeight: FontWeight.bold, // Đậm
              fontFamily: 'Roboto', // Sử dụng font chữ Roboto
            ),
          ),
        ),
      ),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return Consumer<DogBreedProvider>(
      builder: (context, provider, _) {
        return FutureBuilder<void>(
          future: provider.getAllBreedsList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
            } else {
              return _buildList(provider);
            }
          },
        );
      },
    );
  }

  Widget _buildList(DogBreedProvider provider) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getFavoriteBreedsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
        } else {
          final favoriteBreeds = snapshot.data!.docs.map((doc) => doc['breed'] as String).toList();
          return ListView.builder(
            itemCount: favoriteBreeds.length,
            itemBuilder: (context, index) {
              final breedName = favoriteBreeds[index];
              return _FavoriteBreedListItem(breedName: breedName);
            },
          );
        }
      },
    );
  }

  Stream<QuerySnapshot> _getFavoriteBreedsStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('Favorite')
        .where('User', isEqualTo: userId)
        .snapshots();
  }
}

class _FavoriteBreedListItem extends StatelessWidget {
  final String breedName;

  const _FavoriteBreedListItem({Key? key, required this.breedName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dogProvider = Provider.of<DogBreedProvider>(context, listen: false);
    final isFavorite = dogProvider.favoriteBreeds.contains(breedName);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      horizontalTitleGap: 20,
      title: Container(
        height: 250,
        child: Stack(
          children: [
            ImageViewAndTitle(
              ontap: () {
                // Handle tapping on the favorite breed item, if needed
              },
              title: breedName,
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  _toggleFavorite(context, breedName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(BuildContext context, String breedName) {
    final dogProvider = Provider.of<DogBreedProvider>(context, listen: false);
    dogProvider.toggleFavorite(breedName);

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final favoriteRef = FirebaseFirestore.instance.collection('Favorite');
      final userFavoriteRef = favoriteRef.where('User', isEqualTo: userId).where('breed', isEqualTo: breedName);

      userFavoriteRef.get().then((snapshot) {
        if (snapshot.size > 0) {
          snapshot.docs.first.reference.delete();
        } else {
          favoriteRef.add({
            'User': userId,
            'breed': breedName,
          });
        }
      }).catchError((error) {
        print('Error toggling favorite: $error');
      });
    }
  }
}
