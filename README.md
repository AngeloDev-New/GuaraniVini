# 📘 Dicionário Guarani-Português - API

API simples desenvolvida com Flask para manipulação de traduções entre português e guarani, com suporte ao envio de áudio e download do aplicativo Android.

---

## 🚀 Executando a API localmente

### 🔧 Requisitos:

* Python 3.8+
* pip
* Flask

### ▶️ Como rodar:

```bash
pip install -r requirements.txt
python app.py
```

O servidor iniciará em `http://localhost:5000/`

---

## 📡 Rotas da API

### 📘 `GET /dict.json`

Retorna o conteúdo do dicionário com traduções de palavras entre **português** e **guarani**.

#### 🔁 Exemplo de uso:

```bash
curl http://localhost:5000/dict.json
```

#### 📦 Resposta:

```json
[
  {
    "portugues": "casa",
    "guarani": "óga"
  },
  ...
]
```

---

### 📱 `GET /apk`

Faz o download do arquivo `.apk` do aplicativo mobile Android.

#### 🔁 Exemplo de uso:

```bash
curl -O http://localhost:5000/apk
```

> O arquivo `app-profile.apk` será salvo no diretório atual.

---

### 🎙️ `POST /audio/save.php`

Salva um arquivo de áudio enviado, juntamente com informações da frase correspondente. Também atualiza o dicionário se uma correção for enviada.

#### 📤 Parâmetros (form-data):

* `audio`: arquivo de áudio (`.wav`, `.mp3`, etc.)
* `frase`: JSON contendo os dados da frase
* `correcao` *(opcional)*: nova palavra ou expressão corrigida em guarani
* `index` *(opcional)*: índice do item a ser corrigido
* `palavra` *(opcional)*: termo em português correspondente

#### 🔁 Exemplo de uso:

```bash
curl -X POST http://localhost:5000/audio/save.php \
  -F "audio=@meu_audio.wav" \
  -F 'frase={"portugues":"casa","guarani":"óga"}' \
  -F "correcao=óga nova" \
  -F "index=0" \
  -F "palavra=casa"
```

#### 📦 Resposta:

```json
{
  "status": "sucesso",
  "message": "Áudio e frase salvos com sucesso.",
  "audio_url": "uploads/audio/meu_audio.wav",
  "frase": {
    "portugues": "casa",
    "guarani": "óga nova"
  }
}
```

---

## 🗂️ Estrutura de Pastas (parcial)

```
app/
├── static/
├── apk/
│   └── app-profile.apk
├── web/
│   └── *webContents*
├── templates/
├── utils/
│   └── helpers.py
├── dict.json
└──  routes.py
uploads/
└── audio/
```

---

## 📄 Licença

Este projeto é de uso livre para fins educativos e não possui fins lucrativos.
