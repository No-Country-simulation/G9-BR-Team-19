package com.techmind.team19.dto;

import jakarta.validation.constraints.NotBlank;

public record DadosConsultaConteudos(
        @NotBlank(message = "Campo obrigatório")
        String titulo,
        @NotBlank(message = "Campo obrigatório")
        String texto) {
}
