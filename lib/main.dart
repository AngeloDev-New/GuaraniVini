import 'package:flutter/material.dart';
import 'dart:async';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(App());

Future<List<Map<String, String>>> getGithub(String link) async {
  final url = Uri.parse(link);
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map<Map<String, String>>((item) => Map<String, String>.from(item)).toList();
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  } catch (e) {
    print('Erro ao fazer requisição do json... Erro: $e');
  }
  return [];
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecorderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecorderScreen extends StatefulWidget {
  @override
  _RecorderScreenState createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool showOptions = false;
  bool isPlaying = false;
  Duration _recordDuration = Duration.zero;
  Duration _playbackPosition = Duration.zero;
  Timer? _recordTimer;
  Timer? _playbackTimer;
  final Record _recorder = Record();
  final AudioPlayer _player = AudioPlayer();
  String? _filePath;
  final double buttonSize = 80;
  TextEditingController _correctionController = TextEditingController();
  bool isCorrectionConfirmed = false;

  final Color terracotta = Color(0xFFE2725B);
  final Color forestGreen = Color(0xFF228B22);
  final Color sand = Color(0xFFF4EBD0);
  final Color skyBlue = Color(0xFF87CEEB);
  final Color darkBrown = Color(0xFF5D3A00);

  List<Map<String, String>> frases = [];
  int cont = 0;
  Map<String, String> fraseAtual = {'': ''};

  @override
  void initState() {
    super.initState();
    loadFrases();
  }

  Future<void> loadFrases() async {
    frases = await getGithub('https://raw.githubusercontent.com/AngeloDev-New/GuaraniVini/master/assets/dict.json');
    setState(() {
      if (frases.isNotEmpty) fraseAtual = frases[cont];
    });
  }

  Map<String, String> nextFrase() {
    if (cont + 1 < frases.length) {
      return frases[++cont];
    }
    return {};
  }

  Future<void> _startRecording() async {
    bool hasPermission = await _recorder.hasPermission();
    if (hasPermission) {
      Directory tempDir = await getTemporaryDirectory();
      _filePath = '${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(path: _filePath!);
      setState(() {
        isRecording = true;
        _recordDuration = Duration.zero;
      });
      _recordTimer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          _recordDuration += Duration(seconds: 1);
        });
      });
    }
  }

  Future<void> _stopRecording() async {
    _recordTimer?.cancel();
    await _recorder.stop();
    setState(() {
      isRecording = false;
      showOptions = true;
    });
  }

  void _cancelRecording() {
    setState(() {
      showOptions = false;
      _recordDuration = Duration.zero;
      _correctionController.clear();
      isCorrectionConfirmed = false;
    });
  }

  void _sendRecording() async {
    if (_filePath == null) return;
    String fraseTexto = fraseAtual['portugues']?.replaceAll(RegExp(r'\s+'), '_') ?? "frase_default";
    String timestamp = (DateTime.now().millisecondsSinceEpoch % 100000).toString().padLeft(5, '0');
    String nomeArquivo = '$fraseTexto$timestamp.webm';
    var request = http.MultipartRequest('POST', Uri.parse('https://brsystems.app.br/audio/save.php'));
    var file = await http.MultipartFile.fromPath('audio', _filePath!, filename: nomeArquivo);
    request.files.add(file);
    request.fields['frase'] = json.encode(fraseAtual);
    request.fields['correcao'] = _correctionController.text;
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          showOptions = false;
          _recordDuration = Duration.zero;
          _correctionController.clear();
          isCorrectionConfirmed = false;
          fraseAtual = nextFrase();
        });
      }
    } catch (e) {
      print("Erro ao enviar áudio: $e");
    }
  }

  Future<void> _playPauseAudio() async {
    if (_filePath == null) return;
    if (isPlaying) {
      await _player.pause();
      _playbackTimer?.cancel();
      setState(() => isPlaying = false);
    } else {
      await _player.setFilePath(_filePath!);
      await _player.play();
      setState(() {
        isPlaying = true;
        _playbackPosition = Duration.zero;
      });
      _playbackTimer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {
          _playbackPosition += Duration(seconds: 1);
        });
        if (_playbackPosition >= _recordDuration) {
          _playbackTimer?.cancel();
          setState(() => isPlaying = false);
        }
      });
      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _playbackTimer?.cancel();
          setState(() => isPlaying = false);
        }
      });
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  void _confirmCorrection() {
    setState(() => isCorrectionConfirmed = true);
  }

  void _editCorrection() {
    setState(() => isCorrectionConfirmed = false);
  }

  Widget _buildTimeline() {
    double percent = (_recordDuration.inSeconds == 0)
        ? 0
        : (_playbackPosition.inSeconds / _recordDuration.inSeconds).clamp(0.0, 1.0);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 4,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: percent,
        child: Container(
          decoration: BoxDecoration(
            color: forestGreen,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  void _resetFrases() {
    setState(() {
      cont = 0;
      if (frases.isNotEmpty) fraseAtual = frases[cont];
    });
  }

  Widget _buildEndOfFrasesScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'As frases acabaram!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkBrown),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _resetFrases,
            icon: Icon(Icons.replay),
            label: Text("Reiniciar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: forestGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _recordTimer?.cancel();
    _playbackTimer?.cancel();
    _correctionController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showTimer = showOptions && !isRecording;
    return Scaffold(
      backgroundColor: sand,
      appBar: AppBar(
        title: Text('Gravador de Áudio Indígena'),
        backgroundColor: terracotta,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: frases.isEmpty
              ? CircularProgressIndicator()
              : cont >= frases.length
                  ? _buildEndOfFrasesScreen()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Capture frases em Guarani para preservar nossa cultura!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkBrown),
                        ),
                        SizedBox(height: 20),
                        Text('Guarani: ${fraseAtual['guarani'] ?? ''}', style: TextStyle(fontSize: 20, color: forestGreen)),
                        Text('Português: ${fraseAtual['portugues'] ?? ''}', style: TextStyle(fontSize: 16, color: terracotta)),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: isRecording ? _stopRecording : _startRecording,
                          child: Icon(isRecording ? Icons.stop : Icons.mic, size: 40),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(24),
                            backgroundColor: isRecording ? terracotta : forestGreen,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        if (showOptions) ...[
                          _buildTimeline(),
                          Text(_formatDuration(_recordDuration), style: TextStyle(fontSize: 16)),
                          IconButton(
                            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: _playPauseAudio,
                          ),
                          if (!isCorrectionConfirmed) ...[
                            TextField(
                              controller: _correctionController,
                              decoration: InputDecoration(labelText: 'Correção (opcional)'),
                            ),
                            ElevatedButton(
                              onPressed: _confirmCorrection,
                              child: Text('Confirmar Correção'),
                            )
                          ] else ...[
                            Text('Correção confirmada: ${_correctionController.text}'),
                            ElevatedButton(
                              onPressed: _editCorrection,
                              child: Text('Editar'),
                            )
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(onPressed: _sendRecording, child: Text('Enviar')),
                              ElevatedButton(onPressed: _cancelRecording, child: Text('Cancelar')),
                            ],
                          )
                        ]
                      ],
                    ),
        ),
      ),
    );
  }
}
