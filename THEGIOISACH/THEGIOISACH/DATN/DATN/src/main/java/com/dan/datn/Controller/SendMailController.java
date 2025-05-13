package com.dan.datn.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SendMailController {
    @GetMapping("/sendmail")
    public String sendmail(Model model) {
        return "index/sendmail";
    }
}
