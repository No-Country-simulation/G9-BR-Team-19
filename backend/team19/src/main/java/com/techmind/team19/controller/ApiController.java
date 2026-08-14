package com.techmind.team19.controller;

import com.techmind.team19.domain.queryResult.QueryResult;
import com.techmind.team19.domain.queryResult.QueryResultRepository;
import com.techmind.team19.domain.tag.Tag;
import com.techmind.team19.domain.tag.TagRepository;
import com.techmind.team19.domain.user.User;
import com.techmind.team19.domain.user.UserRepository;
import com.techmind.team19.dto.DadosConsultaConteudos;
import com.techmind.team19.dto.DadosRespostaConteudo;
import com.techmind.team19.service.ConteudoStorageService;
import com.techmind.team19.service.QueryTagService;
import com.techmind.team19.service.ServiceDados;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@io.swagger.v3.oas.annotations.tags.Tag(name = "Conteúdos", description = "Endpoints para processamento de conteúdos.")
public class ApiController {

    @Autowired
    private ConteudoStorageService storageService;

    @Autowired
    private ServiceDados serviceDados;

    @Autowired
    private QueryTagService tagService;

    @Autowired
    private QueryResultRepository resultRepository;

    @Autowired
    private TagRepository tagRepository;

    @Autowired
    private UserRepository userRepository;

    @Operation(summary = "Processa um Conteúdo", description = "Recebe um título e um texto, envia para o modelo de IA e retorna o resultado.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Conteúdo enviado com sucesso."),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor.")
    })
    @PostMapping("/conteudos/processar")
    public ResponseEntity<DadosRespostaConteudo> processar(@RequestBody @Valid DadosConsultaConteudos dados, Authentication authentication) {

        DadosRespostaConteudo resposta = serviceDados.chamarModeloDados(dados);

        var tags = tagService.SalvarTagRepository(resposta);

        User user = userRepository
                .findEntityByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        var queryResult = new QueryResult(resposta, tags, user);
        resultRepository.save(queryResult);

        return ResponseEntity.ok(resposta);
    }

    @Operation(summary = "Retorna a lista de consultas do usuário logado", description = "Chama o metodo listarBiblioteca() da classe ConteudoStorageService para listar os conteudos referente ao usuário logado.")
    @GetMapping("/biblioteca")
    public ResponseEntity<List<QueryResult>> biblioteca(Authentication authentication) {
        return ResponseEntity.ok(storageService.listarBiblioteca(authentication));
    }

    @DeleteMapping("/conteudos/{id}")
    public ResponseEntity excluir(@PathVariable Long id, Authentication authentication) {

        User user = userRepository
                .findEntityByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));

        QueryResult result = resultRepository
                .findByIdAndUser(id, user)
                .orElseThrow(() -> new RuntimeException("Consulta não encontrada"));

        resultRepository.delete(result);

        return ResponseEntity.noContent().build();
    }

}
