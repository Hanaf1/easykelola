import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  String _name = "staff";
  String _email = "staff@gmail.com";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Fungsi untuk memuat data dari SharedPreferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "staff";
      _email = prefs.getString('email') ?? "staff@gmail.com";
      String? imagePath = prefs.getString('profileImage');
      if (imagePath != null && File(imagePath).existsSync()) {
        _profileImage = File(imagePath);
      } else {
        _profileImage = null; // Fallback jika file tidak ditemukan
      }
    });
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImage', pickedImage.path);
    }
  }

  // Fungsi untuk menyimpan nama dan email
  Future<void> _saveProfile(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    setState(() {
      _name = name;
      _email = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Settings Staff',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(
                      _profileImage!,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 72,
                      height: 72,
                      color: Colors.grey[300],
                      child: const Icon(Icons.person, size: 40, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    _showEditDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(Icons.security, color: Colors.black),
              title: const Text('Data Security'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.headset_mic, color: Colors.black),
              title: const Text('Support Center'),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {},
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Dialog untuk mengedit nama dan email
  void _showEditDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: _name);
    final TextEditingController emailController = TextEditingController(text: _email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveProfile(nameController.text, emailController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
