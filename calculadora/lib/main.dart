import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora SENAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _display = '0';
  double _resultado = 0;
  String _operacao = '';
  bool _novoNumero = true;

  void _pressionarNumero(String numero) {
    setState(() {
      if (_novoNumero) {
        _display = numero;
        _novoNumero = false;
      } else {
        if (_display == '0') {
          _display = numero;
        } else {
          _display += numero;
        }
      }
    });
  }

  void _pressionarOperacao(String operacao) {
    setState(() {
      double numeroAtual = double.parse(_display);
      
      if (_operacao.isNotEmpty) {
        _calcular();
      } else {
        _resultado = numeroAtual;
      }
      
      _operacao = operacao;
      _novoNumero = true;
    });
  }

  void _calcular() {
    setState(() {
      double numeroAtual = double.parse(_display);
      
      switch (_operacao) {
        case '+':
          _resultado += numeroAtual;
          break;
        case '-':
          _resultado -= numeroAtual;
          break;
        case '*':
          _resultado *= numeroAtual;
          break;
        case '/':
          if (numeroAtual != 0) {
            _resultado /= numeroAtual;
          }
          break;
      }
      
      _display = _resultado.toString();
      _operacao = '';
      _novoNumero = true;
    });
  }

  void _limpar() {
    setState(() {
      _display = '0';
      _resultado = 0;
      _operacao = '';
      _novoNumero = true;
    });
  }

  void _adicionarVirgula() {
    setState(() {
      if (!_display.contains('.')) {
        _display += '.';
        _novoNumero = false;
      }
    });
  }

  Widget _botao(
    String texto, {
    VoidCallback? onPressed,
    Color? corFundo,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: corFundo ?? Colors.grey[300],
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora SENAI'),
        backgroundColor: const Color.fromARGB(255, 133, 193, 243),
      ),
      body: Column(
        children: [
          // Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 226, 226,-226),
            child: Text(
              _display,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          // Botões
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Row 1: C, /, *, -
                    Row(
                      children: [
                        _botao('C',
                            onPressed: _limpar,
                            corFundo: Colors.red[300]),
                        _botao('/',
                            onPressed: () => _pressionarOperacao('/'),
                            corFundo: Colors.orange[300]),
                        _botao('*',
                            onPressed: () => _pressionarOperacao('*'),
                            corFundo: Colors.orange[300]),
                        _botao('-',
                            onPressed: () => _pressionarOperacao('-'),
                            corFundo: Colors.orange[300]),
                      ],
                    ),
                    // Row 2: 7, 8, 9, +
                    Row(
                      children: [
                        _botao('7', onPressed: () => _pressionarNumero('7')),
                        _botao('8', onPressed: () => _pressionarNumero('8')),
                        _botao('9', onPressed: () => _pressionarNumero('9')),
                        _botao('+',
                            onPressed: () => _pressionarOperacao('+'),
                            corFundo: Colors.orange[300]),
                      ],
                    ),
                    // Row 3: 4, 5, 6
                    Row(
                      children: [
                        _botao('4', onPressed: () => _pressionarNumero('4')),
                        _botao('5', onPressed: () => _pressionarNumero('5')),
                        _botao('6', onPressed: () => _pressionarNumero('6')),
                      ],
                    ),
                    // Row 4: 1, 2, 3
                    Row(
                      children: [
                        _botao('1', onPressed: () => _pressionarNumero('1')),
                        _botao('2', onPressed: () => _pressionarNumero('2')),
                        _botao('3', onPressed: () => _pressionarNumero('3')),
                      ],
                    ),
                    // Row 5: 0, ., =
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => _pressionarNumero('0'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                foregroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _botao('.',
                            onPressed: _adicionarVirgula,
                            corFundo: Colors.grey[300]),
                        _botao('=',
                            onPressed: _calcular,
                            corFundo: Colors.green[300]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
