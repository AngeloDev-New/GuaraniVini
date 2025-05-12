from flask import Response,send_file, abort ,current_app, jsonify
import json
import os
import io

def getBin(filepath):
    full_path = os.path.join(current_app.root_path, filepath)
    
    if not os.path.exists(full_path):
        return abort(404, description=f"Arquivo não encontrado {current_app.root_path}")

    return send_file(
        full_path,
        as_attachment=True,
        download_name=os.path.basename(full_path),
        mimetype='application/vnd.android.package-archive'
    )


def getHtml(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            html_content = f.read()
            return Response(html_content, mimetype='text/html')
    except FileNotFoundError:
        return Response("<h1>Arquivo não encontrado</h1>", status=404, mimetype='text/html')



def getJson(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return Response(json.dumps(data, ensure_ascii=False, indent=2), mimetype='application/json')
    except FileNotFoundError:
        return Response(json.dumps({'erro': 'Arquivo JSON não encontrado.'}), status=404, mimetype='application/json')


def getCss(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            return Response(f.read(), mimetype='text/css')
    except FileNotFoundError:
        return Response("/* Arquivo CSS não encontrado */", status=404, mimetype='text/css')


import os
from flask import Response

def getJs(filepath):
    try:
        if not os.path.exists(filepath):
            return Response("// Arquivo JS não encontrado", status=404, mimetype='application/javascript')
            
        with open(filepath, 'r', encoding='utf-8') as f:
            return Response(f.read(), mimetype='application/javascript')
    except Exception as e:
        # Log de erro
        print(f"Erro ao abrir o arquivo {filepath}: {e}")
        return Response("// Erro ao carregar o arquivo JS", status=500, mimetype='application/javascript')



def getFont(filepath):
    try:
        with open(filepath, 'rb') as f:
            ext = os.path.splitext(filepath)[1].lower()
            mimetypes = {
                '.ttf': 'font/ttf',
                '.otf': 'font/otf',
                '.woff': 'font/woff',
                '.woff2': 'font/woff2'
            }
            mimetype = mimetypes.get(ext, 'application/octet-stream')
            return Response(f.read(), mimetype=mimetype)
    except FileNotFoundError:
        return Response("Arquivo de fonte não encontrado", status=404, mimetype='text/plain')
    except Exception as e:
        return Response(f"Erro ao acessar fonte: {str(e)}", status=500, mimetype='text/plain')


def salvar_audio_e_frase(audio_file, form_data):
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

    frase_dados = form_data.get('frase')
    correcao = form_data.get('correcao')
    index = form_data.get('index')
    portugues = form_data.get('palavra')

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

    if correcao:
        print('corrigindo Banco')
        caminho_arquivo = os.path.join(current_app.root_path, 'dict.json')
        try:
            with open(caminho_arquivo, 'r', encoding='utf-8') as dic_file:
                dados = json.load(dic_file)

            for significado in dados:
                if significado['portugues'] == portugues:
                    significado['guarani'] = correcao

            with open(caminho_arquivo, 'w', encoding='utf-8') as dic_file:
                json.dump(dados, dic_file, indent=2, ensure_ascii=False)

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