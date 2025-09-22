package edu.galileo.agenda.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "Aplicación desplegada en Render<br>" +
                "Nombre: Angelo Estrada<br>" +
                "Carnet: 05189095";
    }
}
