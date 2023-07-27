// This code handles uploading and retrieving images to/from Firebase Cloud Storage.

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final firebase_storage.FirebaseStorage storage = 
  firebase_storage.FirebaseStorage.instance;

  // This function takes an XFile object and uploads it to Firebase Cloud Storage 
  Future<void> uploadImage(XFile image) async {
    await storage.ref('images/${image.name}').putFile(File(image.path));
  }

  // This function takes a Uint8List of bytes and uploads the image data to Firebase Cloud Storage
  Future<void> uploadBytes(Uint8List bytes, String imageName) async {
    await storage.ref().child('images/$imageName').putData(bytes);
  }

  // This function retrieves the download URL of image stored in Firebase Cloud Storage under the "images" directory
  Future<String> getDownloadURL(String imageName) async {
    String downloadURL = 
      await storage.ref('images/$imageName').getDownloadURL();
    
    return downloadURL;
  }
}

