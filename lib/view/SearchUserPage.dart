import 'package:aprendendo_flutter/components/custom_appbar.dart';
import 'package:aprendendo_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key? key}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  List<User> _users = []; // Agora uma lista de objetos User
  bool _isLoading = false; // Para controlar o estado de carregamento
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    _userBox = await Hive.openBox('userBox');
    _fetchUsers();
  }

  // Função que busca os usuários e atualiza o estado da tela
  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true; // Inicia o estado de carregamento
    });

    try {
      // Buscar usuários da API
      List<User> apiUsers = await _fetchUsersFromApi();
      
      // Buscar usuários do Hive
      List<User> localUsers = _fetchUsersFromHive();
      
      setState(() {
        _users = [...apiUsers, ...localUsers];
        _isLoading = false; // Finaliza o carregamento
      });
    } catch (error) {
      setState(() {
        _isLoading = false; // Finaliza o carregamento em caso de erro
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar usuários: $error')),
      );
    }
  }

  // Função que busca os usuários da API
  Future<List<User>> _fetchUsersFromApi() async {
    final response = await http.get(Uri.parse(
        'https://mock-868c475208134bcc97a04620cbe15778.mock.insomnia.rest/api/users'));

    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      // Mapeia o JSON para uma lista de objetos User
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar usuários da API');
    }
  }

  List<User> _fetchUsersFromHive() {
    List<User> users = [];
    String? username = _userBox.get('username');
    String? password = _userBox.get('password');
    
    if (username != null && password != null) {
      users.add(User(username: username, password: password));
    }
    
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Procura Usuário", // Título passado ao AppBar
        showBackButton: false, // Se você quiser esconder a seta de voltar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchUsers,
              child: const Text('Buscar Usuários'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: _users.isEmpty
                        ? const Text('Nenhum usuário encontrado')
                        : ListView.builder(
                            itemCount: _users.length,
                            itemBuilder: (context, index) {
                              final user = _users[index];
                              return ListTile(
                                title: Text(user.username),
                                subtitle: Text(user.password),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
