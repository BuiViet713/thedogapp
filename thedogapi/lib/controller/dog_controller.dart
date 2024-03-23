import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:provider/provider.dart';
import 'package:thedogapi/data/get_all_breeds_model.dart';
import 'package:thedogapi/controller/repository/dog_repository.dart';

class DogBreedProvider with ChangeNotifier {
  DogRepository dogRepository;

  DogBreedProvider(this.dogRepository);
  List<String> dogBreedsNames = [];
  List<String> defaultBreedList = [];
  GetAllDogModel? allBreedData;
  bool firstTimeBreedLoading = false;
  List<String> favoriteBreeds = [];

  // Function to extract dog breeds from the map
  void extractDogBreeds(Map<String, List<String>> data) {
    dogBreedsNames = data.keys.toList();
    defaultBreedList = dogBreedsNames;
    notifyListeners();
  }

  //filter dog breeed
  void filterDogBreeds(String filter) {
    if (filter.isNotEmpty) {
      List<String> filteredList = dogBreedsNames
          .where((breed) =>
              !breed.toString().toLowerCase().contains(filter.toLowerCase()))
          .toList();
      dogBreedsNames = filteredList;
    } else {
      dogBreedsNames = defaultBreedList;
    }
    notifyListeners();
  }
  void setFavoriteBreeds(List<String> breeds) {
    favoriteBreeds = breeds;
    notifyListeners();
  }


  void toggleFavorite(String breedName) {
    if (favoriteBreeds.contains(breedName)) {
      favoriteBreeds.remove(breedName);
    } else {
      favoriteBreeds.add(breedName);
    }
    notifyListeners();
  }
  // Add this method to remove a breed from favorites

//get all dog breed
  Future<void> getAllBreedsList() async {
    if (firstTimeBreedLoading == false) {
      GetAllDogModel listRequest = await dogRepository.getAllBreeds();

      extractDogBreeds(listRequest.breeds);
      allBreedData = listRequest;
      firstTimeBreedLoading = true;
      notifyListeners();
    }
  }
}

