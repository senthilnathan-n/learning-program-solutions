package com.library.repository;

public class BookRepository {
    public void saveBook(String title) {
        System.out.println("BookRepository: Book \"" + title + "\" saved.");
    }
}
