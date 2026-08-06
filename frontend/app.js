document.addEventListener("DOMContentLoaded", () => {
  
  const tabButtons = document.querySelectorAll(".tab-btn");
  const tabContents = document.querySelectorAll(".tab-content");

  tabButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      tabButtons.forEach((b) => b.classList.remove("active"));
      tabContents.forEach((c) => c.classList.remove("active"));

      btn.classList.add("active");
      const targetId = btn.getAttribute("data-target");
      document.getElementById(targetId).classList.add("active");
    });
  });

  const formAnalise = document.getElementById("form-analise");
  const cardForm = document.getElementById("card-form-analise");
  const cardResultado = document.getElementById("card-resultado-analise");
  const btnNovaAnalise = document.getElementById("btn-nova-analise");

  formAnalise.addEventListener("submit", (e) => {
    e.preventDefault();

    cardForm.classList.add("hidden");

    cardResultado.classList.remove("hidden");
  });

  btnNovaAnalise.addEventListener("click", () => {
    formAnalise.reset();

    cardResultado.classList.add("hidden");
    cardForm.classList.remove("hidden");
  });

});