from flask import Blueprint, request, jsonify, current_app
import json, os


# Definindo o Blueprint para agrupar as rotas de usuários
main_bp = Blueprint('main', __name__)
# def audio/save.php
@main_bp.route('/dict.json', methods=['GET'])
def getData():
    caminho_arquivo = os.path.join(current_app.root_path, 'dict.json')  # Isso resolve o caminho com base na pasta da aplicação
    try:
        with open(caminho_arquivo, 'r', encoding='utf-8') as dic:
            data = json.load(dic)
            print (data)
            return jsonify(data)
    except FileNotFoundError:
        return jsonify({'erro': 'Arquivo data.json não encontrado.'}), 404




@main_bp.route('/audio/save.php', methods=['POST'])
def audio_save():
    print('tentando Salvar')
    """
    Salva o áudio enviado e registra a frase associada.
    """
    # Verificando se o arquivo de áudio foi enviado
    if 'audio' not in request.files:
        return jsonify({
            "status": "erro",  # Indica que houve um erro
            "message": "Arquivo de áudio não enviado."  # Mensagem informando o erro
        }), 400  # Código HTTP 400 indica Bad Request (requisição inválida)

    # Recuperando o arquivo de áudio
    audio_file = request.files['audio']
    if audio_file.filename == '':
        return jsonify({
            "status": "erro",
            "message": "Nenhum arquivo selecionado."  # Se o arquivo não foi escolhido
        }), 400

    # Definindo onde o arquivo será salvo (diretório de upload)
    upload_folder = 'uploads/audio'
    if not os.path.exists(upload_folder):
        os.makedirs(upload_folder)


    # Gerando o caminho completo para salvar o arquivo
    file_path = os.path.join(upload_folder, audio_file.filename)
    
    # Salvando o arquivo no diretório de uploads
    audio_file.save(file_path)
    print(f'Audio salvo em ${file_path}')
    # Recuperando a frase (dados) que foi enviada com o áudio
    frase_dados = request.form.get('frase')  # A frase foi enviada como JSON, então vamos decodificá-la
    if not frase_dados:
        return jsonify({
            "status": "erro",
            "message": "Dados da frase não encontrados."
        }), 400

    frase_dados = json.loads(frase_dados)

    # Você pode salvar esses dados ou processá-los conforme necessário
    # Aqui, apenas estamos retornando uma resposta com o nome do arquivo salvo
    return jsonify({
        "status": "sucesso",  # Indica que a operação foi bem-sucedida
        "message": "Áudio e frase salvos com sucesso.",
        "audio_url": file_path,  # Retornando a URL ou caminho onde o áudio foi salvo
        "frase": frase_dados  # Retornando os dados da frase que foram enviados
    }), 200  # Código HTTP 200 indica que a criação foi bem-sucedida