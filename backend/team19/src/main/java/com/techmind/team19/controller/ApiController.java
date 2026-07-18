package com.techmind.team19.controller;

import com.techmind.team19.dto.DadosConsultaConteudos;
import com.techmind.team19.dto.DadosRespostaConteudo;
import com.techmind.team19.service.ConteudoStorageService;
import com.techmind.team19.service.ServiceDados;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@Tag(name = "Conteúdos", description = "Endpoints para processamento de conteúdos.")
public class ApiController {

    @Autowired
    private ConteudoStorageService storageService;

    @Autowired
    private ServiceDados serviceDados;

    @Operation(summary = "Processa um Conteúdo", description = "Recebe um título e um texto, envia para o modelo de IA e retorna o resultado.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Conteúdo enviado com sucesso."),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor.")
    })
    @PostMapping("/conteudos/processar")
    public ResponseEntity<DadosRespostaConteudo> processar(@RequestBody @Valid DadosConsultaConteudos dados) {

        DadosRespostaConteudo resposta = serviceDados.chamarModeloDados(dados);

        storageService.salvar(resposta);

        return ResponseEntity.ok(resposta);
    }

    @Operation(summary = "Retorna a lista de consultas", description = "Chama o metodo listar() da classe ConteudoStorageService para listar os conteudos consultados.")
    @GetMapping("/conteudos")
    public ResponseEntity<List<DadosRespostaConteudo>> listar() {
        return ResponseEntity.ok(storageService.listar());
    }

}
