import 'package:flutter/material.dart';
import 'dart:async';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apppresenca/main.dart';
import 'package:apppresenca/model/gittool.dart';

class RecorderScreenState extends State<RecorderScreen> with SingleTickerProviderStateMixin {
Map<String, String> fraseAtual  = {};      
List<Map<String,String>> frases=[];
bool hasPermission = false;
int cont = 0;
int fl = 0;
Future<void> loadFrases() async {
    frases = await getGithub('https://raw.githubusercontent.com/AngeloDev-New/GuaraniVini/master/assets/dict.json');
    
    fl = frases.length;
    print('Itens recuperados ${fl}...');
    hasPermission = await _recorder.hasPermission();
    
    setState(() {
      if (frases.isNotEmpty) fraseAtual = frases[cont++];
      
    });
} 
  RecorderScreenState(){
    print('>>>>>>>>>>>>>RecorderScreenState');
    loadFrases();
  }
  Map<String,String> nextFrase(){
    return frases[cont++];
  }
  
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

  // Paleta de cores indígena
  final Color terracotta = Color(0xFFE2725B);
  final Color forestGreen = Color(0xFF228B22);
  final Color sand = Color(0xFFF4EBD0);
  final Color skyBlue = Color(0xFF87CEEB);
  final Color darkBrown = Color(0xFF5D3A00);

  // Map<String, String> fraseAtual = nextFrase();

  Future<void> _startRecording() async {
    // bool hasPermission = await _recorder.hasPermission();

    if (hasPermission) {
      Directory tempDir = await getTemporaryDirectory();
      _filePath = '${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _recorder.start(path: _filePath!, encoder: AudioEncoder.AAC);

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
  print("Enviado com duração: $_recordDuration e correção: ${_correctionController.text}");

  // Supondo que você tenha o arquivo de áudio gravado em _filePath
  if (_filePath == null) {
    print("Não há arquivo para enviar.");
    return;
  }

  // Garantindo que 'fraseAtual['portugues']' não seja nulo antes de chamar replaceAll
  String fraseTexto = fraseAtual['portugues']?.replaceAll(RegExp(r'\s+'), '_') ?? "frase_default";

  // Gerando o timestamp aleatório de 5 dígitos
  String timestamp = (DateTime.now().millisecondsSinceEpoch % 100000).toString().padLeft(5, '0');

  // Nome do arquivo com a frase e timestamp
  String nomeArquivo = '$fraseTexto$timestamp.webm';
  print(nomeArquivo);
  var request = http.MultipartRequest('POST', Uri.parse('https://brsystems.app.br/audio/save.php'));

  // Adicionando o arquivo de áudio ao request com o nome gerado
  var file = await http.MultipartFile.fromPath('audio', _filePath!, filename: nomeArquivo);
  request.files.add(file);

  // Adicionando a frase no request como JSON
  request.fields['frase'] = json.encode(fraseAtual);

  // Adicionando a correção no request, se necessário
  request.fields['correcao'] = _correctionController.text;

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Áudio enviado com sucesso!");
      setState(() {
        showOptions = false;
        _recordDuration = Duration.zero;
        _correctionController.clear();
        isCorrectionConfirmed = false;
        fraseAtual = nextFrase(); // Preparar próxima frase
      });
    } else {
      print("Erro ao enviar áudio: ${response.statusCode}");
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
      setState(() {
        isPlaying = false;
      });
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
          setState(() {
            isPlaying = false;
          });
        }
      });

      _player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _playbackTimer?.cancel();
          setState(() {
            isPlaying = false;
          });
        }
      });
    }
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  void _confirmCorrection() {
    setState(() {
      isCorrectionConfirmed = true;
    });
  }

  void _editCorrection() {
    setState(() {
      isCorrectionConfirmed = false;
    });
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
      fraseAtual = nextFrase();
    });
  }

  Widget _buildEndOfFrasesScreen() {
    print('Tem:${fl} frases e o contador esta em ${cont}');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (fl <= cont) ...[
                _buildEndOfFrasesScreen(),
              ] else ...[
                Text(
                  'Capture frases em Guarani para preservar nossa cultura!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkBrown),
                ),
                SizedBox(height: 20),
                Text('Guarani: ${fraseAtual['guarani']}',
                    style: TextStyle(fontSize: 16, color: forestGreen)),
                Text('Português: ${fraseAtual['portugues']}',
                    style: TextStyle(fontSize: 16, color: skyBlue)),
                SizedBox(height: 20),
                if (isRecording || isPlaying || showTimer) ...[
                  Text(
                    isRecording
                        ? _formatDuration(_recordDuration)
                        : _formatDuration(_playbackPosition),
                    style: TextStyle(fontSize: 18, color: darkBrown),
                  ),
                ],
                if (isRecording || isPlaying) _buildTimeline(),
                GestureDetector(
                  onLongPressStart: (_) => _startRecording(),
                  onLongPressEnd: (_) => _stopRecording(),
                  onTap: showOptions ? _playPauseAudio : null,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: isRecording
                          ? terracotta
                          : (showOptions ? skyBlue : forestGreen),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isRecording
                          ? Icons.mic
                          : (showOptions
                              ? (isPlaying ? Icons.pause : Icons.play_arrow)
                              : Icons.mic),
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                if (showOptions) ...[
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _cancelRecording,
                        icon: Icon(Icons.close),
                        label: Text("Cancelar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkBrown,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: _sendRecording,
                        icon: Icon(Icons.send),
                        label: Text("Enviar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: forestGreen,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Divider(),
                  Text(
                    'Correção (Guarani):',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: darkBrown, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _correctionController,
                          enabled: !isCorrectionConfirmed,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: sand,
                            border: OutlineInputBorder(),
                            hintText: 'Digite a tradução correta...',
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      isCorrectionConfirmed
                          ? IconButton(
                              icon: Icon(Icons.close, color: terracotta),
                              onPressed: _editCorrection,
                            )
                          : ElevatedButton(
                              onPressed: _confirmCorrection,
                              child: Text("Confirmar"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: forestGreen,
                                foregroundColor: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ]
              ],
            ],
          ),
        ),
      ),
    );
  }
}
