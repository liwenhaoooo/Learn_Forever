package com.online_course.server.exception;

/**
 * @author wenhaoli
 * @date 2022/06/17 21:53
 */
public class ValidatorException extends RuntimeException{

    public ValidatorException(String message) {
        super(message);
    }
}
