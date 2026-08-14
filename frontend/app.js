// URL do backend, ajustar conforme o ambiente (local, docker-compose, OCI)
const API_BASE_URL = 'http://localhost:8080';
const PROCESSAR_ENDPOINT = `${API_BASE_URL}/api/conteudos/processar`;

document.addEventListener('DOMContentLoaded', () => {

  const viewLanding = document.getElementById('view-landing');
  const viewApp = document.getElementById('view-app');

  const modalLogin = document.getElementById('modal-login');
  const modalRegister = document.getElementById('modal-register');
  const formLogin = document.getElementById('form-login');
  const formRegister = document.getElementById('form-register');

  const btnStart = document.querySelector('.start');
  const btnLoginLanding = document.querySelector('.login-btn-landing');

  const closeLoginBtn = modalLogin.querySelector('.close-modal');
  const closeRegisterBtn = modalRegister.querySelector('.close-modal');
  const linkToRegister = document.getElementById('link-to-register');
  const linkToLogin = document.getElementById('link-to-login');

  const tabBtns = document.querySelectorAll('.tab-btn');
  const tabContents = document.querySelectorAll('.tab-content');

  const flipCard = document.getElementById('main-flip-card');
  const formAnalise = document.getElementById('form-analise');
  const btnConsultar = document.getElementById('btn-consultar');
  const btnFazerNovaAnalise = document.getElementById('btn-nova-analise');
  const btnVerBibliotech = document.getElementById('btn-ver-bibliotech');

  const inputTitulo = document.getElementById('titulo');
  const inputConteudo = document.getElementById('conteudo');

  const resCategoria = document.getElementById('res-categoria');
  const resTags = document.getElementById('res-tags');
  const resResumo = document.getElementById('res-resumo');

  function showApp() {
    viewLanding.classList.add('hidden');
    viewApp.classList.remove('hidden');
    switchTab('tab-nova-analise');
  }

  function switchTab(targetId) {
    tabBtns.forEach(btn => {
      if (btn.dataset.target === targetId) btn.classList.add('active');
      else btn.classList.remove('active');
    });

    tabContents.forEach(content => {
      if (content.id === targetId) {
        content.classList.remove('hidden');
        content.classList.add('active');
      } else {
        content.classList.add('hidden');
        content.classList.remove('active');
      }
    });
  }

  btnStart.addEventListener('click', () => {
    showApp();
  });

  btnLoginLanding.addEventListener('click', () => {
    modalLogin.classList.remove('hidden');
  });

  closeLoginBtn.addEventListener('click', () => {
    modalLogin.classList.add('hidden');
  });

  closeRegisterBtn.addEventListener('click', () => {
    modalRegister.classList.add('hidden');
    modalLogin.classList.remove('hidden');
  });

  linkToRegister.addEventListener('click', (e) => {
    e.preventDefault();
    modalLogin.classList.add('hidden');
    modalRegister.classList.remove('hidden');
  });

  linkToLogin.addEventListener('click', (e) => {
    e.preventDefault();
    modalRegister.classList.add('hidden');
    modalLogin.classList.remove('hidden');
  });

  formLogin.addEventListener('submit', (e) => {
    e.preventDefault();
    modalLogin.classList.add('hidden');
    showApp();
  });

  formRegister.addEventListener('submit', (e) => {
    e.preventDefault();
    modalRegister.classList.add('hidden');
    showApp();
  });

  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      switchTab(btn.dataset.target);
    });
  });

  function preencherTags(tags) {
    resTags.innerHTML = '';

    if (!tags || tags.length === 0) {
      const vazio = document.createElement('span');
      vazio.className = 'tag-box';
      vazio.textContent = 'Sem tags';
      resTags.appendChild(vazio);
      return;
    }

    tags.forEach(tag => {
      const tagBox = document.createElement('span');
      tagBox.className = 'tag-box';
      tagBox.textContent = `#${tag}`;
      resTags.appendChild(tagBox);
    });
  }

  async function extrairMensagemErro(response) {
    try {
      const corpo = await response.json();
      if (corpo && corpo.message) return corpo.message;
      const primeiraChave = Object.keys(corpo || {})[0];
      if (primeiraChave) return corpo[primeiraChave];
    } catch (_) {
    }
    return `Erro ao processar (status ${response.status})`;
  }

  async function processarConteudo(titulo, texto) {
    const response = await fetch(PROCESSAR_ENDPOINT, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ titulo, texto })
    });

    if (!response.ok) {
      throw new Error(await extrairMensagemErro(response));
    }

    return response.json();
  }

  formAnalise.addEventListener('submit', async (e) => {
    e.preventDefault();

    const titulo = inputTitulo.value.trim();
    const texto = inputConteudo.value.trim();

    if (!titulo || !texto) {
      alert('Preencha titulo e texto antes de consultar.');
      return;
    }

    btnConsultar.disabled = true;
    btnConsultar.textContent = 'Consultando...';

    try {
      const resultado = await processarConteudo(titulo, texto);

      resCategoria.textContent = resultado.categoria || '\u2014';
      preencherTags(resultado.tags);
      resResumo.textContent = resultado.resumo || '\u2014';

      flipCard.classList.add('flipped');
    } catch (err) {
      console.error('Falha ao consultar a API:', err);
      alert(err.message || 'Nao foi possivel consultar a API. Tente novamente.');
    } finally {
      btnConsultar.disabled = false;
      btnConsultar.textContent = 'Consultar';
    }
  });

  btnFazerNovaAnalise.addEventListener('click', () => {
    flipCard.classList.remove('flipped');
    formAnalise.reset();
  });

  btnVerBibliotech.addEventListener('click', () => {
    switchTab('tab-bibliotech');
  });

  /* ==========================================
     LÓGICA DA INTERFACE BIBLIOTECH
     ========================================== */

  // Elementos da Bibliotech
  const inputBusca = document.getElementById('input-busca');
  const btnDropdown = document.querySelector('.btn-dropdown');
  const dropdownMenu = document.querySelector('.dropdown-menu');
  const dropdownItems = document.querySelectorAll('.dropdown-item');
  const cardsGrid = document.querySelector('.cards-grid');

  // 1. Abrir/Fechar Dropdown de Categorias
  if (btnDropdown && dropdownMenu) {
    btnDropdown.addEventListener('click', (e) => {
      e.stopPropagation();
      dropdownMenu.classList.toggle('hidden');
    });
  }

  // 2. Filtrar por Categoria no Dropdown
  dropdownItems.forEach(item => {
    item.addEventListener('click', (e) => {
      e.preventDefault();
      dropdownItems.forEach(i => i.classList.remove('active', 'selected'));
      item.classList.add('selected');

      const categoriaSelecionada = item.textContent.trim().toLowerCase();
      filtrarCards(inputBusca?.value.trim().toLowerCase() || '', categoriaSelecionada);

      dropdownMenu.classList.add('hidden');
    });
  });

  // 3. Busca por Texto em Tempo Real
  if (inputBusca) {
    inputBusca.addEventListener('input', (e) => {
      const termo = e.target.value.trim().toLowerCase();
      const itemAtivo = document.querySelector('.dropdown-item.selected');
      const categoriaAtiva = itemAtivo ? itemAtivo.textContent.trim().toLowerCase() : 'todas';

      filtrarCards(termo, categoriaAtiva);
    });
  }

  // Função Auxiliar para Filtrar Cards
  function filtrarCards(termoTexto, categoria) {
    const cards = document.querySelectorAll('.tech-card:not(.empty-card)');

    cards.forEach(card => {
      const titulo = card.querySelector('.card-title')?.textContent.toLowerCase() || '';
      const descricao = card.querySelector('.card-description')?.textContent.toLowerCase() || '';
      const badge = card.querySelector('.card-badge')?.textContent.toLowerCase() || '';

      const bateTexto = !termoTexto || titulo.includes(termoTexto) || descricao.includes(termoTexto) || badge.includes(termoTexto);
      const bateCategoria = !categoria || categoria === 'todas' || badge === categoria;

      card.style.display = (bateTexto && bateCategoria) ? 'flex' : 'none';
    });
  }

  // 4. Ações dos Cards (Visualizar e Excluir)
  if (cardsGrid) {
    cardsGrid.addEventListener('click', (e) => {
      const btnDelete = e.target.closest('.btn-delete');
      const btnVisualizar = e.target.closest('.btn-visualizar');
      const card = e.target.closest('.tech-card');

      if (btnDelete && card) {
        if (confirm('Deseja realmente remover este item da sua Bibliotech?')) {
          card.remove();
        }
      } else if (btnVisualizar && card) {
        const titulo = card.querySelector('.card-title')?.textContent;
        alert(`Visualizando detalhes de: ${titulo}`);
      }
    });
  }

  // Fechar Dropdown ao Clicar Fora
  document.addEventListener('click', (e) => {
    if (dropdownMenu && !dropdownMenu.contains(e.target) && !btnDropdown?.contains(e.target)) {
      dropdownMenu.classList.add('hidden');
    }
  });


});
