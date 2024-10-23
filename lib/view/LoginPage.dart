import 'dart:io';
import 'dart:typed_data';

import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:aprendendo_flutter/components/custom_buttom.dart';
import 'package:aprendendo_flutter/view/Home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _imageBytes; // Armazenar a imagem como bytes
  late Box _imageBox; // A Box do Hive para armazenar os bytes da imagem
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false; // Controla se a senha está visível ou não
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _imageBox = await Hive.openBox('profileBox'); // Abre ou cria a Box
    _userBox = await Hive.openBox('userBox'); // Abre ou cria a Box
    _loadImageFromHive(); // Carrega a imagem salva no Hive (se houver)
  }

  void _loadImageFromHive() {
    Uint8List? storedImage =
        _imageBox.get('profileImage'); // Recupera os bytes da imagem
    if (storedImage != null) {
      setState(() {
        _imageBytes = storedImage;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _saveImageToHive(File(pickedFile.path));
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _saveImageToHive(File(pickedFile.path));
    }
  }

  Future<void> _saveImageToHive(File image) async {
    final Uint8List imageBytes =
        await image.readAsBytes(); // Converte a imagem em bytes
    setState(() {
      _imageBytes = imageBytes; // Atualiza o estado para exibir a imagem
    });
    _imageBox.put(
        'profileImage', imageBytes); // Salva os bytes da imagem na Box
  }

  Future<bool> _createUser() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String image = base64Encode(_imageBytes!);

    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(
              'https://mock-868c475208134bcc97a04620cbe15778.mock.insomnia.rest/api/users'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': username,
            'password': password,
            'image': image,
          }),
        );

        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          // Salvar username e password no Hive
          await _userBox.put('username', username);
          await _userBox.put('password', password);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário criado com sucesso!')),
          );
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao criar usuário: ${response.body}')),
          );
          return false;
        }
      } catch (e) {
        print('Erro ao enviar requisição: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao criar usuário.')),
        );
        return false;
      }
    }
    return false;
  }

  List<String> _validatePassword(String? password) {
    List<String> errors = [];

    if (password == null || password.isEmpty) {
      errors.add('Por favor, insira uma senha');
    }
    if (password!.length < 8) {
      errors.add('A senha deve ter pelo menos 8 caracteres');
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add('A senha deve conter pelo menos uma letra maiúscula');
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add('A senha deve conter pelo menos uma letra minúscula');
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add('A senha deve conter pelo menos um número');
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      errors.add('A senha deve conter um caracter especial (!@#\$&*~)');
    }

    return errors;
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Criar Login"),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(  // Adicionando o Form aqui
          key: _formKey,  // Chave do Form
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exibe a imagem de perfil, ou um placeholder se não houver imagem
              _imageBytes != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(_imageBytes!),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 60),
                    ),
              const SizedBox(height: 60),
              CustomButtom(
                buttonText: "Tirar Foto",
                onPressed: _pickImageFromCamera,
              ),
              const SizedBox(height: 20),
              CustomButtom(
                buttonText: "Selecionar Imagem da Galeria",
                onPressed: _pickImageFromGallery,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o usuário';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16), // Espaço entre os campos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    List<String> errors = _validatePassword(value);
                    if (errors.isNotEmpty) {
                      return errors.join('\n');
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButtom(
                buttonText: "Criar Login",
                onPressed: () async {
                  // Chama o método _createUser
                  final bool isUserCreated = await _createUser();

                  // Se o usuário for criado com sucesso, navega para a Home
                  if (isUserCreated) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
  }
}
