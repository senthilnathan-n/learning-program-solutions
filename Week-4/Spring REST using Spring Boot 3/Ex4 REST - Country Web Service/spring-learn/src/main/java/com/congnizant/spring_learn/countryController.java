package com.congnizant.spring_learn;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import model.country;

@RestController
public class countryController {

    private static final Logger LOGGER = LoggerFactory.getLogger(countryController.class);

    @RequestMapping("/country")
    public country getCountryIndia() {
        LOGGER.info("START: getCountryIndia()");
        ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
        country country = (country) context.getBean("in");
        LOGGER.info("END: getCountryIndia()");
        return country;
    }
}