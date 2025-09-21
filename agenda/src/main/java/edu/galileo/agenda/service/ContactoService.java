package edu.galileo.agenda.service;

import edu.galileo.agenda.model.Contacto;
import edu.galileo.agenda.model.repository.ContactoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContactoService {
    @Autowired
    private ContactoRepository contactoRepository;
    public Contacto add (Contacto contacto){
        return this.contactoRepository.save(contacto);
    }
    public List<Contacto> List (){
        return this.contactoRepository.findAll();
    }
}
