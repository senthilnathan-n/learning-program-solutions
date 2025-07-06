package com.library.repository;

public class BookRepository {
    public void recordBorrow(String title) {
        System.out.println("Book \"" + title + "\" borrowed. Logging transaction...");
    }
}
