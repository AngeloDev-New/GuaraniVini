const frases = [
  // Palavras isoladas
  { guarani: "Eéi", portugues: "Sim" },
  { guarani: "Nahã", portugues: "Não" },
  { guarani: "Aguyje", portugues: "Obrigado" },
  { guarani: "Nderehegua", portugues: "Por favor" },
  { guarani: "Avy'a", portugues: "Olá" },
  { guarani: "Jajotopata", portugues: "Tchau" },
  { guarani: "Teta", portugues: "Mãe" },
  { guarani: "Tata", portugues: "Pai" },
  { guarani: "Mitã", portugues: "Filho" },
  { guarani: "Y", portugues: "Água" },
  { guarani: "Aña", portugues: "Fogo" },
  { guarani: "Yvypóra", portugues: "Terra" },
  { guarani: "Yvágape", portugues: "Céu" },
  { guarani: "Mbopi", portugues: "Comida" },
  { guarani: "Róga", portugues: "Casa" },
  { guarani: "Mbo'ehára", portugues: "Animal" },
  { guarani: "Aña pyahu", portugues: "Flor" },
  { guarani: "Jasy", portugues: "Lua" },
  { guarani: "Aña'", portugues: "Sol" },
  { guarani: "Tavẽ", portugues: "Espírito" },
  { guarani: "Karai", portugues: "Homem" },
  { guarani: "Kuñakarai", portugues: "Mulher" },
  { guarani: "Karu", portugues: "Comer" },
  { guarani: "Guata", portugues: "Caminhar" },
  { guarani: "Mba'e", portugues: "Coisa" },
  { guarani: "Pyhare", portugues: "Noite" },
  { guarani: "Ára", portugues: "Dia" },
  { guarani: "Tekoha", portugues: "Aldeia" },
  { guarani: "Mbopi", portugues: "Peixe" },
  { guarani: "Ñe'ẽ", portugues: "Palavra" },
  { guarani: "Jagua", portugues: "Cachorro" },
  { guarani: "Mbarakaja", portugues: "Gato" },
  { guarani: "Mbopi", portugues: "Peixe" },
  { guarani: "Mbopi guasu", portugues: "Peixe grande" },
  { guarani: "Ka'i", portugues: "Macaco" },
  { guarani: "Mbopi pytã", portugues: "Pacu (peixe vermelho)" },
  { guarani: "Mbopi karape", portugues: "Piranha" },
  { guarani: "Tapiti", portugues: "Coelho do mato" },
  { guarani: "Karaja", portugues: "Tatu" },
  { guarani: "Mborevi", portugues: "Veado" },
  { guarani: "Guasu", portugues: "Anta" },
  { guarani: "Mbopi'i", portugues: "Peixinho" },
  { guarani: "Ñandu", portugues: "Emu / Avestruz sul-americano" },
  { guarani: "Mbopi puku", portugues: "Enguia" },
  { guarani: "Tatu karẽ", portugues: "Tatu-peba" },
  { guarani: "Kururu", portugues: "Sapo" },
  { guarani: "Mbopi hu", portugues: "Peixe preto" },
  { guarani: "Gua'a", portugues: "Arara" },
  { guarani: "Mainumby", portugues: "Beija-flor" },
  { guarani: "Taguato", portugues: "Gavião" },


  // Frases curtas
  { guarani: "Mba'e ka'aru", portugues: "Bom dia" },
  { guarani: "Mba'e pyhare", portugues: "Boa noite" },
  { guarani: "Mba'éichapa re?", portugues: "Como vai você?" },
  { guarani: "Aipota", portugues: "Estou bem" },
  { guarani: "Aikotevẽ", portugues: "Estou cansado" },
  { guarani: "Aikotevẽ yvotýpe", portugues: "Tenho fome" },
  { guarani: "Mba'e reiko?", portugues: "Onde está você?" },
  { guarani: "Ñemohenda", portugues: "Está chovendo" },
  { guarani: "Ñamombu", portugues: "Vamos comer" },
  { guarani: "Aña rorã", portugues: "Eu não sei" },
  { guarani: "Iñanemba?", portugues: "Você está com frio?" },
  { guarani: "Ñe'ẽ hague?", portugues: "Quando vamos sair?" },
  { guarani: "Mba'e hague?", portugues: "O que você está fazendo?" },
  { guarani: "Ñande oñemohendáva?", portugues: "Você quer comer comigo?" },
  { guarani: "Che aikotevẽ py'aguapy", portugues: "Eu preciso de paz" },
  { guarani: "Ndaha'éi mba'eve", portugues: "Não é nada" },
  { guarani: "Che avy'a nderehe", portugues: "Estou feliz por você" },
  { guarani: "Y heta hína", portugues: "Tem muita água" },
  { guarani: "Róga porã", portugues: "Casa bonita" },
  { guarani: "Ko ára haku", portugues: "Hoje está quente" },
  { guarani: "Che karu rire", portugues: "Depois que eu comer" },
  { guarani: "Reikotevẽ pytyvõ?", portugues: "Você precisa de ajuda?" },
  { guarani: "Aikotevẽ y", portugues: "Preciso de água" },
  { guarani: "Che ryguasu ka’aru ho’u", portugues: "Minha galinha come à tarde" },
  { guarani: "Aháta che róga", portugues: "Vou para casa" },
  { guarani: "Ahecháta ne ndive", portugues: "Vou te ver" },
  { guarani: "Eguahẽ porã", portugues: "Chegue bem" },
  { guarani: "Mba'éichapa nde réra?", portugues: "Qual é o seu nome?" },
  { guarani: "Ahayhu nde", portugues: "Eu te amo" },
  { guarani: "Che memby oho mbo'ehaópe", portugues: "Meu filho foi para a escola" },
  { guarani: "Ko pyhareve rokaru", portugues: "Hoje de manhã comemos" },
  { guarani: "Ajapo tembi’u", portugues: "Estou cozinhando" },
  { guarani: "Ndapyta mo'ãi", portugues: "Não vou ficar" },
  { guarani: "Añe’ẽ nderehe", portugues: "Falei de você" },
  { guarani: "Ndorojapói", portugues: "Não faremos" },
  { guarani: "Eike", portugues: "Entre" },
  { guarani: "Eñembo’y", portugues: "Levante-se" },
  { guarani: "Eguapy", portugues: "Sente-se" },
  { guarani: "Ejapo ko’ág̃a", portugues: "Faça agora" },
  { guarani: "Aníke reñemongyhyje", portugues: "Não tenha medo" },
  { guarani: "Nde rejapo porã", portugues: "Você fez bem" },
  { guarani: "Jajapo oñondive", portugues: "Vamos fazer juntos" },

  //frases clima
  { guarani: "Ko ára haku", portugues: "Hoje está quente" },
  { guarani: "Ko pyhare ro'y", portugues: "Esta noite está fria" },
  { guarani: "Oñemohenda ama", portugues: "Vai chover" },
  { guarani: "Ohasáma ama", portugues: "A chuva já passou" },
  { guarani: "Hakueterei", portugues: "Está muito quente" },
  { guarani: "Ro'yeterei", portugues: "Está muito frio" },
  { guarani: "Yvytu hatã oĩ", portugues: "Está ventando forte" },
  { guarani: "Yvytu porã oĩ", portugues: "Está ventando suavemente" },
  { guarani: "Ara resẽ", portugues: "O sol apareceu" },
  { guarani: "Ara kañy", portugues: "O sol se escondeu" },
  { guarani: "Yvágape hovy", portugues: "O céu está azul" },
  { guarani: "Yvágape hũ", portugues: "O céu está nublado" },
  { guarani: "Yvágape pytũ", portugues: "O céu está escuro" },
  { guarani: "Ko’ãga osyry y", portugues: "Agora a água está escorrendo" },
  { guarani: "Yvytu oipeju", portugues: "O vento sopra" },
  { guarani: "Ama oguahẽta", portugues: "A chuva está chegando" },
  { guarani: "Ara hũmba", portugues: "Está completamente nublado" },
  { guarani: "Ara porãite", portugues: "O dia está muito bonito" },
  { guarani: "Che aiko", portugues: "Eu vivo" },
  { guarani: "Che mitã", portugues: "Eu sou uma criança" },
  { guarani: "Aikotevẽ", portugues: "Estou cansado" },

 //frases emoções
  { guarani: "Che avy'a", portugues: "Estou feliz" },
  { guarani: "Che ñembyasy", portugues: "Estou triste" },
  { guarani: "Che pochý", portugues: "Estou bravo" },
  { guarani: "Che kyhyje", portugues: "Estou com medo" },
  { guarani: "Che mbyasy nderehe", portugues: "Sinto muito por você" },
  { guarani: "Che aikotevẽ py'aguapy", portugues: "Preciso de paz" },
  { guarani: "Che jepy'apy", portugues: "Estou preocupado" },
  { guarani: "Che rory", portugues: "Estou sorrindo" },
  { guarani: "Che py'aguapy", portugues: "Estou em paz" },
  { guarani: "Che jekutu", portugues: "Estou magoado" },
  { guarani: "Cheñandu porã", portugues: "Estou me sentindo bem" },
  { guarani: "Aikotevẽ peteĩ ñe'ẽ porã", portugues: "Preciso de uma palavra amiga" },
  { guarani: "Ndaikuaái mba'épa ajapova'erã", portugues: "Não sei o que fazer" },
  { guarani: "Aime ñembyasýpe", portugues: "Estou em luto" },
  { guarani: "Ahecha che angapyhy", portugues: "Sinto saudade" },
  


  // Frases completas
  { guarani: "Che aiko che pyhare rehegua, ñande rapykuere.", portugues: "Eu moro com minha família na aldeia." },
  { guarani: "Che tata ohecha che mbo'ehára.", portugues: "Meu pai trabalha na roça todo dia." },
  { guarani: "Ñamombu ojehechauka ñanemba.", portugues: "Nós vamos pescar no rio amanhã cedo." },
  { guarani: "Ko'ãga, yvágape oñemohenda.", portugues: "Hoje o céu está muito bonito." },
  { guarani: "Mitãrã ohechape ohechauka.", portugues: "As crianças estão brincando perto da escola." },
  { guarani: "Che omba'é ohechauka hague.", portugues: "Minha avó conta histórias antigas à noite." },
  { guarani: "Omarandu ombogueta teko.", portugues: "O pajé conhece muitas plantas medicinais." },
  { guarani: "Yvoty ojehechauka.", portugues: "O vento está forte nesta manhã." },
  { guarani: "Aña tekoha.", portugues: "Eu gosto de ouvir os pássaros cantando." },
  { guarani: "Ñande rapykuere oguerekóva, roga.", portugues: "A floresta é a nossa casa sagrada." },

  // Perguntas simples
  { guarani: "Mba'e ñemohendáva re?", portugues: "Qual é o seu nome?" },
  { guarani: "Iñanemba?", portugues: "Você está com frio?" },
  { guarani: "Ñe'ẽ hague?", portugues: "Quando vamos sair?" },
  { guarani: "Mba'e hague?", portugues: "O que você está fazendo?" },
  { guarani: "Ñande oñemohendáva?", portugues: "Você quer comer comigo?" },
  { guarani: "Mba'e reiko?", portugues: "Onde você mora?" },
  { guarani: "Aña mbo'e?", portugues: "Você está cansado?" },
  { guarani: "Mbopi, eikove?", portugues: "O que você quer comer?" },
  { guarani: "Ñemohenda ojehechauka?", portugues: "Está chovendo?" },
  { guarani: "Máva nde?", portugues: "Quem é você?" },
  { guarani: "Moõpa reho?", portugues: "Aonde você vai?" },
  { guarani: "Mba'érepa reñembyasy?", portugues: "Por que você está triste?" },
  { guarani: "Araka'épa ñañe'ẽ?", portugues: "Quando vamos conversar?" },
  { guarani: "Mba'éichapa nde róga?", portugues: "Como é sua casa?" },
  { guarani: "Ñe'ẽ hague?", portugues: "Onde vamos brincar?" },

  // Comandos simples
  { guarani: "Eguereko avei.", portugues: "Venha aqui." },
  { guarani: "Eguereko.", portugues: "Olhe para lá." },
  { guarani: "Iguereko.", portugues: "Fique quieto." },
  { guarani: "Ejapo hague.", portugues: "Espere um pouco." },
  { guarani: "Ñe'ẽ teko.", portugues: "Vamos embora." },
  { guarani: "Ñemohenda", portugues: "Fique calmo." },
  { guarani: "Eguereko hína.", portugues: "Olhe bem." },
  { guarani: "Ñe'ẽ aña", portugues: "Siga por esse caminho." },
  { guarani: "Epu'ã", portugues: "Levante-se" },
  { guarani: "Eguata", portugues: "Caminhe" },
  { guarani: "E'u", portugues: "Coma" },
  { guarani: "Emboguejy", portugues: "Acalme-se" },
  { guarani: "Ehendu", portugues: "Escute" },
  { guarani: "Eporandumi", portugues: "Pergunte" },
  { guarani: "Embopyhareve", portugues: "Descanse agora" },


  // Frases espirituais e culturais
  { guarani: "Aña hína oikohápe, oikóvo avave.", portugues: "O espírito está presente, no caminho da vida." },
  { guarani: "Ñande reko, ha'eñemohendáva", portugues: "Nossa cultura é ensinada pelos mais velhos." },
  { guarani: "Ñe'ẽme guasu oñemohendáva ojehecha hague.", portugues: "A grande sabedoria é vista pelos mais antigos." },
  { guarani: "Ñande tekoha, yvypóra rembiapo", portugues: "A nossa aldeia preserva o espírito da terra." },
  { guarani: "Ñe'ẽ pyahu oiko.", portugues: "A nova palavra vai crescer." },
  { guarani: "Ñemohenda, ojehechauka hague", portugues: "O silêncio ensina mais do que palavras." },
  { guarani: "Ñemohenda guasu ohechauka hague", portugues: "O grande silêncio é a voz dos espíritos." },
  { guarani: "Ñe'ẽ he'õ ñande reko rehegua", portugues: "A palavra doce é parte da nossa cultura" },
  { guarani: "Karai guasu oikuaa teko porã", portugues: "O sábio conhece o bom modo de viver" },
  { guarani: "Yvoty oñemoingove ñande rekópe", portugues: "As flores trazem vida ao nosso modo de ser" },
  { guarani: "Tekojoja ha'e ñande rapé", portugues: "A justiça é o nosso caminho" },


  // Frases sobre a natureza e a terra
  { guarani: "Ñande rapykuere ohechauka hague", portugues: "A floresta nos ensina a viver." },
  { guarani: "Ñe'ẽme guasu ojapo hague", portugues: "A palavra sagrada é a raiz da nossa vida." },
  { guarani: "Yvypóra ñamombu hague", portugues: "O homem que pesca respeita o rio." },
  { guarani: "Yvypóra oñemohendáva ojapo hague", portugues: "O homem que vive em harmonia com a terra floresce." },
  { guarani: "Yvoty haku omyesakã ára pyahu", portugues: "A flor quente anuncia um novo dia" },
  { guarani: "Y ojapo mba'e porã ñandéve", portugues: "A água faz o bem para nós" },
  { guarani: "Ka'aguy ombopiro'y ñande korasõ", portugues: "A floresta refresca o nosso coração" },
  { guarani: "Yvágape oñemoarandu ñande py'a", portugues: "O céu ensina ao nosso espírito" }

];

console.log(frases);

let fraseIndex = 0;
let mediaRecorder;
let audioChunks = [];

const fraseGuaraniEl = document.getElementById("frase-guarani");
const frasePortuguesEl = document.getElementById("frase-portugues");
const startBtn = document.getElementById("startBtn");
const nextBtn = document.getElementById("nextBtn");
const statusEl = document.getElementById("status");
const randonBtn = document.getElementById("randonBtn");

function atualizarFrase() {
  const frase = frases[fraseIndex];
  fraseGuaraniEl.textContent = `Guarani: ${frase.guarani}`;
  frasePortuguesEl.textContent = `Português: ${frase.portugues}`;
}

atualizarFrase();

startBtn.onclick = async () => {
  // Se estiver gravando e o botão for clicado novamente, para a gravação
  if (startBtn.textContent.includes("Parar") && mediaRecorder?.state === "recording") {
    mediaRecorder.stop();
    startBtn.textContent = "🎤 Gravar";
    return;
  }

  const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
  mediaRecorder = new MediaRecorder(stream);
  audioChunks = [];

  mediaRecorder.ondataavailable = event => audioChunks.push(event.data);

  mediaRecorder.onstop = () => {
    const audioBlob = new Blob(audioChunks, { type: 'audio/webm' }); // Criação do Blob com o tipo correto
    const formData = new FormData();
  
    // Substituindo espaços por "_" no nome da frase em português
    const fraseTexto = frases[fraseIndex].portugues.replace(/\s+/g, "_");
  
    // Gerando o timestamp aleatório de 5 dígitos
    const timestamp = `${Math.floor(Math.random() * 100000).toString().padStart(5, '0')}`;
  
    // Nome do arquivo com a frase e timestamp
    const nomeArquivo = `${fraseTexto}_${timestamp}.webm`;
  
    // Adicionando o arquivo e a frase no FormData
    formData.append("audio", audioBlob, nomeArquivo);
    formData.append("frase", JSON.stringify(frases[fraseIndex]));
  
    // Enviando os dados para o servidor
    for (let pair of formData.entries()) {
      console.log(pair[0]+ ':', pair[1]);
  }
    fetch("save.php", { 
      method: "POST", 
      body: formData 
    })
    .then(res => res.text())
    .then(res => {
      // Atualizando o status com a resposta do servidor
      statusEl.textContent = "Áudio salvo com sucesso!";
      nextBtn.disabled = false;
      randonBtn.disabled = false;
      startBtn.disabled = true;
      startBtn.textContent = "🎤 Gravar";
    })
    .catch(error => {
      // Tratamento de erro no envio
      console.error('Erro ao salvar o áudio:', error);
      statusEl.textContent = "Erro ao salvar o áudio. Tente novamente.";
    });
  };
  

  mediaRecorder.start();
  statusEl.textContent = "Gravando... fale agora";
  startBtn.textContent = "⏹️ Parar";
};

nextBtn.onclick = () => {
  fraseIndex++;
  if (fraseIndex < frases.length) {
    atualizarFrase();
    startBtn.disabled = false;
    nextBtn.disabled = true;
    statusEl.textContent = "";
  } else {
    fraseGuaraniEl.textContent = "Fim das gravações!";
    frasePortuguesEl.textContent = "";
    startBtn.disabled = true;
    nextBtn.disabled = true;
  }
};

randonBtn.onclick = () => {
  if (frases.length > 0) {
    const randomIndex = Math.floor(Math.random() * frases.length); // pega um índice aleatório
    const fraseSelecionada = frases[randomIndex];

    // Atualiza os elementos de texto
    fraseGuaraniEl.textContent = fraseSelecionada.guarani;
    frasePortuguesEl.textContent = fraseSelecionada.portugues;

    // Remove a frase já usada, para não repetir
    frases.splice(randomIndex, 1);

    startBtn.disabled = false;
    randonBtn.disabled = true;
    statusEl.textContent = "";
  } else {
    fraseGuaraniEl.textContent = "Fim das gravações!";
    frasePortuguesEl.textContent = "";
    startBtn.disabled = true;
    randonBtn.disabled = true;
  }
};