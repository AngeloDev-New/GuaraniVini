Gravador de Áudio Indígena

Este é um aplicativo Flutter para gravação de áudio com suporte para correção do áudio gravado. O app permite que o usuário grave frases em português e as envie para um servidor, juntamente com uma correção opcional. O projeto também oferece a funcionalidade de reprodução de áudios gravados e acompanha o progresso da gravação e da reprodução.
Funcionalidades

    Gravação de Áudio: Grave áudios no formato .m4a com o botão de gravação.

    Reprodução de Áudio: Reproduza áudios gravados com controle de pausa e play.

    Correção de Áudio: O usuário pode adicionar uma correção após a gravação do áudio.

    Envio de Áudio e Correção: Envie o áudio gravado e a correção para um servidor.

    Visualização de Frases: O app exibe frases em português, que podem ser usadas para gravação.

Instalação

Siga os passos abaixo para rodar o projeto localmente:
Pré-requisitos

    Flutter instalado.

    Android Studio ou Visual Studio Code para desenvolvimento Flutter.

Passos

    Clone o repositório:

git clone https://github.com/AngeloDev-New/GravadorIndigena.git

Navegue até o diretório do projeto:

cd GravadorIndigena

Instale as dependências:

flutter pub get

Conecte um dispositivo Android ou inicie o emulador.

Execute o aplicativo:

    flutter run

Pacotes Utilizados

    record: Para gravação de áudio.

    just_audio: Para reprodução de áudio.

    path_provider: Para localizar o diretório temporário para armazenar os arquivos de áudio.

    http: Para fazer requisições HTTP para envio do áudio.

Funcionalidade de Envio

O app envia os áudios gravados e suas correções para um servidor usando o método POST. Para isso, o arquivo é enviado como um MultipartFile e o conteúdo das correções é passado como dados no corpo da requisição.

URL de envio (exemplo):

https://brsystems.app.br/audio/save.php

Estrutura de Dados Enviada

    Áudio: Arquivo de áudio gravado.

    Frase: Frase em português que foi gravada.

    Correção: Correção opcional do áudio gravado.

Como Contribuir

    Faça um fork do projeto.

    Crie uma branch para sua funcionalidade (git checkout -b minha-funcionalidade).

    Comite suas mudanças (git commit -am 'Adiciona nova funcionalidade').

    Push para a branch (git push origin minha-funcionalidade).

    Abra um Pull Request.

Licença

Este projeto é licenciado sob a MIT License.
