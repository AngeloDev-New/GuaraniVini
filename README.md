# Gravador de Áudio Indígena - App Flutter Web e Mobile

Este projeto é um aplicativo Flutter multiplataforma (mobile e web) voltado para a gravação, reprodução e envio de áudios em língua Guarani, contribuindo para a preservação cultural indígena.

## ✅ Status do Projeto

- ✅ **Versão Mobile (Android/iOS)**: funcionando perfeitamente
- ⚠️ **Versão Web**: em desenvolvimento  
  Atualmente, estamos trabalhando para contornar incompatibilidades de bibliotecas Flutter na Web.

## Principais Características

- Interface responsiva para Web e Mobile
- Gravação e reprodução de áudio
- Envio de gravações com metadados
- Correção de frases em Guarani
- Visual nativo com cores da cultura indígena

## Compatibilidade de Bibliotecas

A versão mobile já está totalmente funcional. No entanto, a versão Web exige adaptações por conta de bibliotecas incompatíveis:

| Biblioteca           | Compatível com Web | Observação |
|---------------------|--------------------|------------|
| `path_provider`     | ❌ Não             | Usar `universal_html` ou `shared_preferences` como alternativa |
| `record`            | ⚠️ Parcial        | Funciona com limitações via `MediaRecorder` (navegadores compatíveis) |
| `just_audio`        | ⚠️ Parcial        | Funciona na Web, mas com limitações (ex.: sem efeitos avançados) |
| `http`              | ✅ Sim            | Compatível com Web e Mobile |

> ⚙️ Estamos trabalhando ativamente na adaptação para a Web, buscando substituições compatíveis e implementando soluções nativas baseadas em JavaScript via `dart:html`.

## Estrutura do Projeto

- Adaptação multiplataforma usando `kIsWeb`
- Uso da API `MediaRecorder` e `AudioElement` na Web
- Upload de arquivos com metadados
- Correção de tradução e envio de feedback cultural

## Como Rodar o Projeto

### Pré-requisitos

- Flutter SDK >= 3.9.0
- Dart SDK >= 2.18.0
- Navegador compatível (para testes Web)
- Servidor PHP para receber os áudios (opcional)

### Instalação

```bash
git clone https://github.com/seu-usuario/app-gravador-guarani.git
cd app-gravador-guarani
flutter pub get
