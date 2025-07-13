package com.cognizant.jwtsecurity.controller;

import com.cognizant.jwtsecurity.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Collections;

@RestController
public class AuthenticationController {

    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;
    private final UserDetailsService userDetailsService;

    public AuthenticationController(AuthenticationManager authenticationManager, JwtUtil jwtUtil, UserDetailsService userDetailsService) {
        this.authenticationManager = authenticationManager;
        this.jwtUtil = jwtUtil;
        this.userDetailsService = userDetailsService;
    }

    @PostMapping("/authenticate")
    public ResponseEntity<?> createToken(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Basic ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Missing or invalid Authorization header");
        }

        try {
            String base64Credentials = authHeader.substring("Basic ".length());
            byte[] decoded = Base64.getDecoder().decode(base64Credentials);
            String[] values = new String(decoded, StandardCharsets.UTF_8).split(":", 2);
            String username = values[0];
            String password = values[1];

            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            String jwt = jwtUtil.generateToken(userDetails);

            return ResponseEntity.ok(Collections.singletonMap("token", jwt));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication failed");
        }
    }
}
