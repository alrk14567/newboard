package com.example.newboard.controller;

import com.example.newboard.model.UserDTO;
import com.example.newboard.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/user/")
@RequiredArgsConstructor
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("auth")
    public String auth(UserDTO userDTO, HttpSession session) {
        UserDTO result = userService.auth(userDTO);

        if (result != null) {
            session.setAttribute("logIn", result);
            return "redirect:/board/showAll";
        }

        return "redirect:/";
    }

    @GetMapping("register")
    public String showRegister() {
        return "user/register";
    }

    @PostMapping("register")
    public String register(UserDTO userDTO, RedirectAttributes redirectAttributes) {
        if (userService.validateUsername(userDTO.getUsername()) && userService.validateNickname(userDTO.getNickname())) {

            userService.register(userDTO);
            System.out.println("회원가입 성공!!!");
        } else if (!userService.validateUsername(userDTO.getUsername())) {
            redirectAttributes.addFlashAttribute("message", "아이디가 중복되었습니다.");

            return "redirect:/showMessage";
        } else {
            redirectAttributes.addFlashAttribute("message", "닉네임이 중복되었습니다.");

            return "redirect:/showMessage";
        }
        return "redirect:/";
    }


}
