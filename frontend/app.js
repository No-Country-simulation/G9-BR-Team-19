document.addEventListener("DOMContentLoaded", () => {

  const tabButtons = document.querySelectorAll(".tab-btn");
  const tabContents = document.querySelectorAll(".tab-content");

  tabButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      tabButtons.forEach((b) => b.classList.remove("active"));
      tabContents.forEach((c) => c.classList.remove("active"));

      btn.classList.add("active");
      const targetId = btn.getAttribute("data-target");
      const targetContent = document.getElementById(targetId);

      if (targetContent) {
        targetContent.classList.add("active");
      }
    });
  });

  const formAnalise = document.getElementById("form-analise");
  const cardForm = document.getElementById("card-form-analise");
  const cardResultado = document.getElementById("card-resultado-analise");
  const btnNovaAnalise = document.getElementById("btn-nova-analise");

  if (formAnalise && cardForm && cardResultado) {
    formAnalise.addEventListener("submit", (e) => {
      e.preventDefault();

      cardForm.classList.add("hidden");
      cardResultado.classList.remove("hidden");
    });
  }

  if (btnNovaAnalise && formAnalise && cardForm && cardResultado) {
    btnNovaAnalise.addEventListener("click", () => {
      formAnalise.reset();

      cardResultado.classList.add("hidden");
      cardForm.classList.remove("hidden");
    });
  }

});
