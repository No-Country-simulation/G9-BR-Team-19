document.addEventListener('DOMContentLoaded', () => {
  const flipCard = document.getElementById('main-flip-card');
  const formAnalise = document.getElementById('form-analise');
  const btnNovaAnalise = document.getElementById('btn-nova-analise');

  // Click "Consultar"
  formAnalise.addEventListener('submit', (e) => {
    e.preventDefault();
    flipCard.classList.add('flipped');
  });

  // click "Fazer nova análise"
  btnNovaAnalise.addEventListener('click', () => {
    flipCard.classList.remove('flipped');
  });
});
