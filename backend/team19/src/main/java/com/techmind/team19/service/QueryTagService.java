package com.techmind.team19.service;

import com.techmind.team19.domain.tag.Tag;
import com.techmind.team19.domain.tag.TagRepository;
import com.techmind.team19.dto.DadosRespostaConteudo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
public class QueryTagService {

    @Autowired
    private ServiceDados serviceDados;

    @Autowired
    private TagRepository tagRepository;

    public Set<Tag> SalvarTagRepository(DadosRespostaConteudo resposta) {
        Set<Tag> tags = resposta.tags()
                .stream()
                .map(nome -> tagRepository.findByName(nome)
                        .orElseGet(() -> tagRepository.save(new Tag(nome))))
                        .collect(Collectors.toSet());
        return tags;
    }
}
