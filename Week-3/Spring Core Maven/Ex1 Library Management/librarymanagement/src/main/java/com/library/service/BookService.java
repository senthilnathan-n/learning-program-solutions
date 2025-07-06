package com.library.service;
import com.library.repository.BookRepository;

public class BookService {
    private BookRepository bookRepository;

    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void borrowBook(String title) {
        System.out.println("Processing borrow request...");
        bookRepository.recordBorrow(title);
    }
}
