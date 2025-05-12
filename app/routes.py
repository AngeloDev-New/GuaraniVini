from flask import Blueprint, request, jsonify, current_app
import json, os
from app.utils.helpers import *

# Definindo o Blueprint para agrupar as rotas de usuários
main_bp = Blueprint('main', __name__)

@main_bp.route('/style.css', methods=['GET'])
def style():
    return getCss('app/web/style.css')

@main_bp.route('/dicionari', methods=['GET'])
def dicionari():
    return getHtml('app/web/dicionari.html')

@main_bp.route('/home', methods=['GET'])
def home():
    return getHtml('app/web/develop.html')

@main_bp.route('/dict.json', methods=['GET'])
def getDict():
    return getJson('app/dict.json')

@main_bp.route('/apk', methods=['GET'])
def getApk():
    return getBin('apk/app-profile.apk')

@main_bp.route('/audio/save.php', methods=['POST'])
def audio_save():
    print('tentando Salvar')
    if 'audio' not in request.files:
        return jsonify({
            "status": "erro",
            "message": "Arquivo de áudio não enviado."
        }), 400

    return helpers.salvar_audio_e_frase(request.files['audio'], request.form)

from flask import request, jsonify
import json
import os

@main_bp.route('/atualizedict', methods=['POST'])
def dict_rewrite():
    print('Tentando salvar...')
    data = request.get_json()

    if not data:
        return jsonify({"status": "erro", "message": "JSON inválido."}), 400

    acao = data.get('acao')
    caminho = 'app/dict.json'

    # Carrega o dicionário atual (ou inicializa como lista vazia)
    if os.path.exists(caminho):
        with open(caminho, 'r', encoding='utf-8') as f:
            try:
                dicionario = json.load(f)
                if not isinstance(dicionario, list):
                    dicionario = []
            except json.JSONDecodeError:
                dicionario = []
    else:
        dicionario = []

    try:
        if acao == 'adicionar':
            guarani = data.get('guarani')
            portugues = data.get('portugues')
            if not guarani or not portugues:
                return jsonify({"status": "erro", "message": "Campos obrigatórios ausentes."}), 400
            dicionario.append({"guarani": guarani, "portugues": portugues})

        elif acao == 'editar':
            indice = data.get('indice')
            guarani = data.get('guarani')
            portugues = data.get('portugues')
            if indice is None or not guarani or not portugues:
                return jsonify({"status": "erro", "message": "Dados incompletos para edição."}), 400
            if 0 <= indice < len(dicionario):
                dicionario[indice] = {"guarani": guarani, "portugues": portugues}
            else:
                return jsonify({"status": "erro", "message": "Índice inválido."}), 400

        elif acao == 'remover':
            indice = data.get('indice')
            if indice is None:
                return jsonify({"status": "erro", "message": "Índice não fornecido para remoção."}), 400
            if 0 <= indice < len(dicionario):
                dicionario.pop(indice)
            else:
                return jsonify({"status": "erro", "message": "Índice inválido para remoção."}), 400

        else:
            return jsonify({"status": "erro", "message": "Ação inválida."}), 400

        # Salva o dicionário atualizado
        with open(caminho, 'w', encoding='utf-8') as f:
            json.dump(dicionario, f, ensure_ascii=False, indent=2)

        return jsonify({"status": "sucesso", "message": f"Ação '{acao}' realizada com sucesso."})

    except Exception as e:
        return jsonify({"status": "erro", "message": f"Erro ao processar: {str(e)}"}), 500

