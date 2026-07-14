package com.techmind.team19.dto;

import jakarta.validation.constraints.NotBlank;

public record DadosConsultaConteudos(
        @NotBlank(message = "Titulo obrigatório")
        String titulo,
        @NotBlank(message = "Texto obrigatório")
        String texto) {
}
