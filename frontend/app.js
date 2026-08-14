const API_BASE_URL = `http://${window.location.hostname}:8080`;
const PROCESSAR_ENDPOINT = `${API_BASE_URL}/api/conteudos/processar`;
const LOGIN_ENDPOINT = `${API_BASE_URL}/entrar`;
const SIGNUP_ENDPOINT = `${API_BASE_URL}/cadastrar`;

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

      modalLogin.classList.add('hidden');
      formLogin.reset();
      showApp();
    } catch (err) {
      console.error('Falha no login:', err);
      alert(err.message);
    }
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
});
