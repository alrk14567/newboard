package com.example.newboard.model;

import lombok.Data;

@Data
public class UserDTO {
    private int id;
    private String username;
    private String password;
    private String nickname;
    private int userGrade;
    private String gradeName;
}
