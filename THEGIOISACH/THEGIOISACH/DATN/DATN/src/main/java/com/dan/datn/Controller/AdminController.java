package com.dan.datn.Controller;


import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {
    @Autowired
    private UserServiceImpl userServiceImpl;

    @GetMapping("/admin")
    public String showAdminPage(HttpSession session, Model model) {
        // Lấy email từ session
        String ten = (String) session.getAttribute("ten");

        // Kiểm tra xem email có tồn tại trong session không
        if (ten != null) {
            // Nếu có, tiếp tục xử lý trang quản trị
            model.addAttribute("email", ten);  // Truyền email vào model nếu cần
            return "index/HomeAdmin";  // Hiển thị trang quản trị
        } else {
            // Nếu không có email trong session (chưa đăng nhập), chuyển hướng về trang admin
            return "redirect:/dangnhapadmin";
        }
    }


    @GetMapping("/dangnhapadmin")
    public String dangnhapadmin(Model model) {
        return "index/LoginAdmin";
    }

    @PostMapping("/loginadmin")
    public String loginAdmin(@RequestParam("ten") String ten,
                        @RequestParam("password") String matKhau,
                        Model model,
                        HttpSession session) {
        if (userServiceImpl.validateAdmin(ten, matKhau)) {
            session.setAttribute("ten", ten);
            return "redirect:/admin";
        } else {
            model.addAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            return "index/LoginAdmin";
        }
    }
}
