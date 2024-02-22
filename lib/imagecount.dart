// imagecount.dart

import 'dart:io'; // 파일 클래스를 사용하기 위해 dart:io 패키지를 임포트합니다.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

int imageCount = 7;

// Firebase Authentication을 사용하여 현재 사용자의 UID를 가져오는 함수
Future<String?> getCurrentUserId() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}

// Firebase Storage에서 현재 사용자의 이미지 카운트를 가져오는 함수
Future<int> getImageCount() async {
  try {
    String? userId = await getCurrentUserId();
    if (userId != null) {
      // Firebase Storage에서 사용자별 이미지 카운트 파일 다운로드
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('image_counts')
          .child('$userId/image_count.txt');
      final File countFile = File('image_count.txt');
      await storageRef.writeToFile(countFile);

      // 파일에서 이미지 카운트 읽어오기
      String countString = await countFile.readAsString();
      imageCount = int.parse(countString);

      print('Image count downloaded from Firebase Storage successfully.');
    }
  } catch (e) {
    print('Error downloading image count: $e');
  }
  return imageCount;
}

// Firebase Storage에 현재 사용자의 이미지 카운트를 업데이트하는 함수
Future<void> updateImageCount(int count) async {
  try {
    String? userId = await getCurrentUserId();
    if (userId != null) {
      // 이미지 카운트를 저장할 파일 생성
      File countFile = File('image_count.txt');
      await countFile.writeAsString(count.toString());

      // Firebase Storage에 사용자별 이미지 카운트 파일 업로드
      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('image_counts')
          .child('$userId/image_count.txt');
      await storageRef.putFile(countFile);

      print(
          'Image count updated and uploaded to Firebase Storage successfully.');
    }
  } catch (e) {
    print('Error updating and uploading image count: $e');
  }
}

// Firebase Storage의 이미지 카운트 파일에 대한 설명
void describeImageCountFile() {
  print(
      'The image count is stored in a text file named "image_count.txt" located in the "image_counts" folder in Firebase Storage.');
  print('Each user has their own folder to store their image count.');
}