import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Better Form Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // GlobalKeyでフォームの状態を管理
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // テキストコントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // パスワード表示/非表示の制御
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // メールアドレスのバリデーション
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return '有効なメールアドレスを入力してください';
    }
    return null;
  }

  // パスワードのバリデーション
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    }
    if (value.length < 6) {
      return 'パスワードは6文字以上で入力してください';
    }
    return null;
  }

  // フォーム送信処理
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // バリデーション成功
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ログイン情報が正常に入力されました'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // フォーカスを外す
      },
      behavior: HitTestBehavior.opaque, // 空白部分でもタップを検知
      child: PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ログインフォーム'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          resizeToAvoidBottomInset: true, // キーボード表示時の自動調整
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  // ヘッダーテキスト
                  Text(
                    'アカウントにログイン',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  
                  // メールアドレス入力フィールド
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'メールアドレス',
                      hintText: 'example@email.com',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateEmail,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 20),
                  
                  // パスワード入力フィールド
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'パスワード',
                      hintText: '6文字以上で入力',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    onFieldSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  SizedBox(height: 30),
                  
                  // ログインボタン
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'ログイン',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // フォームリセットボタン
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      _emailController.clear();
                      _passwordController.clear();
                    },
                    child: Text('フォームをリセット'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}