package com.example.retea_gui.domain.validators;

public interface Validator<T> {
    void validate(T entity) throws ValidationException;
}
