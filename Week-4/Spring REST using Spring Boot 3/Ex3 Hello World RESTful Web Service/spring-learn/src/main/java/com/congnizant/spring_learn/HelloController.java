package com.congnizant.spring_learn;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String showMessage() {
        return "Hello, World !!";
    }
}
