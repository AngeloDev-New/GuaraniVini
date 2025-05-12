from flask import Blueprint, request, jsonify, current_app
import json, os
from app.utils.helpers import *

# Definindo o Blueprint para agrupar as rotas de usuários
main_bp = Blueprint('main', __name__)

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
    