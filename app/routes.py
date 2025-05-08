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

    if 'audio' not in request.files:
        return jsonify({
            "status": "erro",
            "message": "Arquivo de áudio não enviado."
        }), 400

    audio_file = request.files['audio']
    if audio_file.filename == '':
        return jsonify({
            "status": "erro",
            "message": "Nenhum arquivo selecionado."
        }), 400

    upload_folder = 'uploads/audio'
    if not os.path.exists(upload_folder):
        os.makedirs(upload_folder)

    file_path = os.path.join(upload_folder, audio_file.filename)
    audio_file.save(file_path)
    print(f'Áudio salvo em {file_path}')

    frase_dados = request.form.get('frase')
    correcao = request.form.get('correcao')
    index = request.form.get('index')

    if not frase_dados:
        return jsonify({
            "status": "erro",
            "message": "Dados da frase não encontrados."
        }), 400

    try:
        index = int(index)
    except (ValueError, TypeError):
        return jsonify({
            "status": "erro",
            "message": "Índice inválido."
        }), 400

    # Atualiza o dict.json apenas se a correção for válida

    if correcao:
        print('corrigindo Banco')
        caminho_arquivo = os.path.join(current_app.root_path, 'dict.json')
        try:
            with open(caminho_arquivo, 'r', encoding='utf-8') as dic_file:
                dados = json.load(dic_file)
            if 0 <= index < len(dados):
                print(correcao)
                dados[index]['guarani'] = correcao
                with open(caminho_arquivo, 'w', encoding='utf-8') as dic_file:
                    json.dump(dados, dic_file, indent=2, ensure_ascii=False)
            else:
                return jsonify({
                    "status": "erro",
                    "message": "Índice fora do alcance do dicionário."
                }), 400
        except Exception as e:
            return jsonify({
                "status": "erro",
                "message": f"Erro ao atualizar dict.json: {str(e)}"
            }), 500

    frase_dados = json.loads(frase_dados)

    return jsonify({
        "status": "sucesso",
        "message": "Áudio e frase salvos com sucesso.",
        "audio_url": file_path,
        "frase": frase_dados
    }), 200
