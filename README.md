# Gravador de Áudio Indígena - App Flutter Web e Mobile

Este projeto é um aplicativo Flutter compatível com web e dispositivos móveis que permite gravar, reproduzir e enviar áudios em língua Guarani para preservação cultural.

## Principais Características

- Interface adaptada para Web e Mobile
- Gravação de áudio em ambas as plataformas
- Reprodução de áudio gravado
- Envio de gravações com metadados
- Correção de frases em Guarani
- Layout nativo com cores inspiradas na cultura indígena

## Estrutura do Projeto

O projeto foi adaptado para funcionar tanto em web quanto em dispositivos móveis, com as seguintes modificações:

- **Abstração de funcionalidades específicas da plataforma**: Uso de detecção de plataforma para oferecer implementações diferentes para web e mobile.
- **Manipulação de áudio web-compatível**: Para a web, usamos as APIs MediaRecorder e AudioElement do navegador.
- **Upload de arquivos multiplataforma**: Implementação específica para cada plataforma.

## Configuração

### Pré-requisitos

- Flutter SDK versão 3.9.0 ou superior
- Dart SDK versão 2.18.0 ou superior
- Servidor PHP para receber os arquivos de áudio (opcional, apenas para funcionalidade completa)

### Instalação

1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/app-gravador-guarani.git
cd app-gravador-guarani
```

2. Instale as dependências
```bash
flutter pub get
```

3. Configure o servidor backend

   - Coloque o arquivo `save.php` em um servidor web com suporte a PHP
   - Crie a pasta `uploads/audio` com permissões de escrita
   - Coloque o arquivo `dict.json` na raiz do servidor

4. Configure a URL do servidor

   Edite a variável `host` no arquivo `web_compatible_app.dart` para apontar para o endereço do seu servidor:

```dart
String host = 'http://seu-servidor.com'; // Substitua pelo endereço do seu servidor
```

### Executando o Projeto

#### Para Web

```bash
flutter run -d chrome
```

#### Para Android

```bash
flutter run -d android
```

#### Para iOS

```bash
flutter run -d ios
```

### Compilando para Produção

#### Web

```bash
flutter build web
```

Os arquivos serão gerados na pasta `build/web` e podem ser hospedados em qualquer servidor web.

#### Android

```bash
flutter build apk
```

ou

```bash
flutter build appbundle
```

#### iOS

```bash
flutter build ipa
```

## Funcionamento

1. O app carrega uma lista de frases em Guarani e Português do servidor
2. O usuário pode gravar a pronúncia correta da frase em Guarani
3. Após gravar, o usuário pode ouvir, cancelar ou enviar a gravação
4. Opcionalmente, o usuário pode fornecer uma correção para a tradução
5. Os áudios são enviados para o servidor com metadados associados

## Personalização

- Edite o arquivo `dict.json` para adicionar ou modificar frases
- Personalize as cores no arquivo `web_compatible_app.dart`
- Modifique o layout conforme necessário

## Solução de Problemas

### Problemas com Permissões de Áudio na Web

Navegadores modernos exigem HTTPS para acessar o microfone. Durante o desenvolvimento, você pode usar:

```bash
flutter run -d chrome --web-hostname localhost --web-port 8080
```

### Problemas com CORS

Se encontrar erros de CORS, verifique se o servidor está configurado corretamente com os headers de Access-Control-Allow-Origin.

## Notas Importantes

- **Compatibilidade Web**: A gravação de áudio na web funciona melhor em Chrome, Firefox e Edge.
- **Formatos de Áudio**: No mobile, o app usa o formato AAC (.m4a), enquanto na web usa o formato WebM.
- **Permissões**: Certifique-se de que seu app solicite as permissões necessárias para acessar o microfone.