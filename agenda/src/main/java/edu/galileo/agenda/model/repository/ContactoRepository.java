package edu.galileo.agenda.model.repository;

import edu.galileo.agenda.model.Contacto;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ContactoRepository extends CrudRepository<Contacto, Integer>{
    @Override
    List<Contacto> findAll();
}
