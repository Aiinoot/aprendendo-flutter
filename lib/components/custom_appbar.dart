import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title; // O título que será passado ao componente
  final bool showBackButton; // Define se a seta de voltar será exibida

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true, // Por padrão, a seta de voltar é exibida
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Uint8List? _imageBytes;
  String? _username;
  late Box _imageBox;
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _imageBox = await Hive.openBox('profileBox');
    _userBox = await Hive.openBox('userBox');
    _loadImageFromHive();
    _loadUsernameFromHive();
  }

  void _loadImageFromHive() {
    Uint8List? storedImage = _imageBox.get('profileImage');
    if (storedImage != null) {
      setState(() {
        _imageBytes = storedImage;
      });
    }
  }

  void _loadUsernameFromHive() {
    String? storedUsername = _userBox.get('username');
    if (storedUsername != null) {
      setState(() {
        _username = storedUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(widget.title),
      actions: [
        if (_username != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Center(
              child: Text(
                _username!,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: _imageBytes != null
                ? MemoryImage(_imageBytes!)
                : null,
            child: _imageBytes == null
                ? Icon(Icons.person, size: 20)
                : null,
          ),
        ),
      ],
    );
  }
}
