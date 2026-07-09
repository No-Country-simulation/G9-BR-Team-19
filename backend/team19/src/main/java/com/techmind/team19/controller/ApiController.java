package com.techmind.team19.controller;

import com.techmind.team19.dto.DadosConsultaConteudos;
import com.techmind.team19.dto.DadosRespostaConteudo;
import com.techmind.team19.service.ConteudoStorageService;
import com.techmind.team19.service.ServiceDados;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ApiController {

    @Autowired
    private ConteudoStorageService storageService;

    @Autowired
    private ServiceDados serviceDados;

    @PostMapping("/conteudos/processar")
    public ResponseEntity<DadosRespostaConteudo> processar(@RequestBody DadosConsultaConteudos dados) {

        DadosRespostaConteudo resposta = serviceDados.chamarModeloDados(dados);

        storageService.salvar(resposta);

        return ResponseEntity.ok(resposta);
    }

    @GetMapping("/conteudos")
    public ResponseEntity<List<DadosRespostaConteudo>> listar() {
        return ResponseEntity.ok(storageService.listar());
    }

}
