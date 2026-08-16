const API_BASE_URL = `http://${window.location.hostname}:8080`;
const PROCESSAR_ENDPOINT = `${API_BASE_URL}/api/conteudos/processar`;
const LOGIN_ENDPOINT = `${API_BASE_URL}/entrar`;
const SIGNUP_ENDPOINT = `${API_BASE_URL}/cadastrar`;
const BIBLIOTECA_ENDPOINT = `${API_BASE_URL}/api/biblioteca`;
const EXCLUIR_CONTEUDO_ENDPOINT = (id) => `${API_BASE_URL}/api/conteudos/${id}`;

document.addEventListener('DOMContentLoaded', () => {

  const viewLanding = document.getElementById('view-landing');
  const viewApp = document.getElementById('view-app');

  const btnUserMenu = document.getElementById('btn-user-menu');
  const userDropdown = document.getElementById('user-dropdown');
  const btnLogout = document.getElementById('btn-logout');
  const userNameDisplay = document.getElementById('user-name-display');
  const modalLogin = document.getElementById('modal-login');
  const modalSignup = document.getElementById('modal-signup');
  const formLogin = document.getElementById('form-login');
  const formSignup = document.getElementById('form-signup');

  const btnStart = document.querySelector('.start');
  const btnLoginLanding = document.querySelector('.login-btn-landing');

  const closeLoginBtn = modalLogin.querySelector('.close-modal');
  const closeSignupBtn = modalSignup.querySelector('.close-modal');
  const linkToSignup = document.getElementById('link-to-signup');
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
  const resProbabilidade = document.getElementById('res-probabilidade');
  const resTags = document.getElementById('res-tags');
  const resResumo = document.getElementById('res-resumo');

  function checkExistingSession() {
      const storedName = localStorage.getItem('techmind_user_name');
      const storedToken = localStorage.getItem('techmind_token');

      if (storedName && storedToken) {
        userNameDisplay.textContent = storedName;
      }
    }

    checkExistingSession();

    formLogin.addEventListener('submit', async (e) => {
      e.preventDefault();

      const email = document.getElementById('login-email').value.trim();
      const password = document.getElementById('login-password').value.trim();

      try {
        const response = await fetch(LOGIN_ENDPOINT, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email, password })
        });

        if (!response.ok) {
          throw new Error('Credenciais inválidas ou erro no servidor.');
        }

        const data = await response.json();

        localStorage.setItem('techmind_token', data.token);
        localStorage.setItem('techmind_user_name', data.name);

        userNameDisplay.textContent = data.name;

        modalLogin.classList.add('hidden');
        formLogin.reset();
        showApp();
      } catch (err) {
        console.error('Falha no login:', err);
        alert(err.message);
      }
    });

      btnUserMenu.addEventListener('click', (e) => {
        e.stopPropagation();
        userDropdown.classList.toggle('hidden');
      });

      document.addEventListener('click', (e) => {
        if (!userDropdown.contains(e.target) && !btnUserMenu.contains(e.target)) {
          userDropdown.classList.add('hidden');
        }
      });

      btnLogout.addEventListener('click', () => {
        localStorage.removeItem('techmind_token');
        localStorage.removeItem('techmind_user_name');

        userNameDisplay.textContent = 'Usuário';
        userDropdown.classList.add('hidden');

        viewApp.classList.add('hidden');
        viewLanding.classList.remove('hidden');
      });

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
    const storedToken = localStorage.getItem('techmind_token');

    if (storedToken) {
      showApp();
    } else {
      modalLogin.classList.remove('hidden');
    }
  });

  btnLoginLanding.addEventListener('click', () => {
    modalLogin.classList.remove('hidden');
  });

  closeLoginBtn.addEventListener('click', () => {
    modalLogin.classList.add('hidden');
  });

  closeSignupBtn.addEventListener('click', () => {
    modalSignup.classList.add('hidden');
    modalLogin.classList.remove('hidden');
  });

  linkToSignup.addEventListener('click', (e) => {
    e.preventDefault();
    modalLogin.classList.add('hidden');
    modalSignup.classList.remove('hidden');
  });

  linkToLogin.addEventListener('click', (e) => {
    e.preventDefault();
    modalSignup.classList.add('hidden');
    modalLogin.classList.remove('hidden');
  });

  formSignup.addEventListener('submit', async (e) => {
    e.preventDefault();

    const name = document.getElementById('signup-name').value.trim();
    const email = document.getElementById('signup-email').value.trim();
    const password = document.getElementById('signup-password').value.trim();

    try {
      const response = await fetch(SIGNUP_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, email, password })
      });

      if (!response.ok) {
        throw new Error('Erro ao cadastrar. O email já pode estar em uso.');
      }

      alert('Cadastro realizado com sucesso! Faça login para continuar.');

      modalSignup.classList.add('hidden');
      modalLogin.classList.remove('hidden');
      formSignup.reset();
    } catch (err) {
      console.error('Falha no cadastro:', err);
      alert(err.message);
    }
  });

  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      switchTab(btn.dataset.target);
      if (btn.dataset.target === 'tab-bibliotech') {
        carregarBibliotech();
      }
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
      const token = localStorage.getItem('techmind_token');

      if (!token) {
        throw new Error('Usuário não autenticado. Por favor, faça login novamente.');
      }

      const response = await fetch(PROCESSAR_ENDPOINT, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ titulo, texto })
      });

      if (!response.ok) {
        if (response.status === 403 || response.status === 401) {
            localStorage.removeItem('techmind_token');
            throw new Error('Sessão expirada ou inválida. Faça login novamente.');
        }
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
      resProbabilidade.textContent = resultado.probabilidade ? `${resultado.probabilidade}%` : '\u2014';
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
    carregarBibliotech();
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

  // Monta um card a partir de um item retornado por /api/biblioteca
  function criarCardBibliotech(item) {
    const card = document.createElement('div');
    card.className = 'tech-card';
    card.dataset.id = item.id;

    card.innerHTML = `
      <div class="card-top">
        <span class="card-badge">${item.categoria || '\u2014'}</span>
      </div>
      <div class="card-body">
        <h3 class="card-title">${item.titulo || '\u2014'}</h3>
        <p class="card-description">${item.resumo || '\u2014'}</p>
      </div>
      <div class="card-footer">
        <button type="button" class="btn-visualizar">Visualizar</button>
        <button type="button" class="btn-delete" title="excluir" aria-label="Excluir">
          <i class="fa-solid fa-trash-can"></i>
        </button>
      </div>
    `;

    return card;
  }

  // Busca os itens salvos do usuário logado e renderiza no grid
  async function carregarBibliotech() {
    const token = localStorage.getItem('techmind_token');

    if (!token || !cardsGrid) return;

    try {
      const response = await fetch(BIBLIOTECA_ENDPOINT, {
        headers: { 'Authorization': `Bearer ${token}` }
      });

      if (!response.ok) {
        if (response.status === 401 || response.status === 403) {
          localStorage.removeItem('techmind_token');
        }
        throw new Error(await extrairMensagemErro(response));
      }

      const itens = await response.json();

      cardsGrid.innerHTML = '';

      if (!itens || itens.length === 0) {
        const vazio = document.createElement('p');
        vazio.className = 'bibliotech-empty';
        vazio.textContent = 'Nenhuma análise salva ainda.';
        cardsGrid.appendChild(vazio);
        return;
      }

      itens.forEach(item => cardsGrid.appendChild(criarCardBibliotech(item)));
    } catch (err) {
      console.error('Falha ao carregar a Bibliotech:', err);
    }
  }

  // 4. Ações dos Cards (Visualizar e Excluir)
  if (cardsGrid) {
    cardsGrid.addEventListener('click', async (e) => {
      const btnDelete = e.target.closest('.btn-delete');
      const btnVisualizar = e.target.closest('.btn-visualizar');
      const card = e.target.closest('.tech-card');

      if (btnDelete && card) {
        if (!confirm('Deseja realmente remover este item da sua Bibliotech?')) return;

        const token = localStorage.getItem('techmind_token');
        const id = card.dataset.id;

        try {
          const response = await fetch(EXCLUIR_CONTEUDO_ENDPOINT(id), {
            method: 'DELETE',
            headers: { 'Authorization': `Bearer ${token}` }
          });

          if (!response.ok && response.status !== 204) {
            throw new Error(await extrairMensagemErro(response));
          }

          card.remove();
        } catch (err) {
          console.error('Falha ao excluir item:', err);
          alert(err.message || 'Não foi possível excluir o item.');
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
