package com.dan.datn.Controller;

import com.dan.datn.Entity.User;
import com.dan.datn.Service.ServiceImpl.EmailService;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DangKyController {

    @Autowired
    private UserServiceImpl userServiceImpl;

    @Autowired
    private EmailService emailService; // Inject EmailValidator

    @GetMapping("/dangky")
    public String showDangKyForm(Model model) {
        model.addAttribute("user", new User()); // sử dụng Admin entity
        return "index/dangKy"; // trả về trang đăng ký
    }

    @PostMapping("/dangky")
    public String registerUser(@ModelAttribute("user") User user, Model model,
                               @RequestParam String hovaten,
                               @RequestParam String ten,
                               @RequestParam String matKhau,
                               @RequestParam("confirm-password") String confirmPassword,
                               @RequestParam String diachi,
                               @RequestParam String sdt, // Đổi kiểu dữ liệu sang String
                               @RequestParam String email) {
        if (userServiceImpl.istenExist(ten)) {
            model.addAttribute("error", "Tên này đã được đăng ký.");
            return "index/dangKy";
        }
        if (ten == null || ten.trim().isEmpty()) {
            model.addAttribute("error", "Tên đăng nhập không được để trống.");
            return "index/dangKy";
        }
        if (!sdt.startsWith("0") ) { // Kiểm tra số điện thoại phải bắt đầu bằng 0
            model.addAttribute("error", "Số điện thoại phải bắt đầu bằng số 0.");
            return "index/dangKy";
        }
        if (sdt.length() != 10){
            model.addAttribute("error", "Số điện thoại không hơpj lệ.");
            return "index/dangKy";
        }
        if (userServiceImpl.isPhoneExist(sdt)) {
            model.addAttribute("error", "Số điện thoại này đã được đăng ký.");
            return "index/dangKy";
        }
        if (userServiceImpl.isEmailExist(email)) {
            model.addAttribute("error", "Email này đã được đăng ký.");
            return "index/dangKy";
        }
        if (!matKhau.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không trùng khớp.");
            return "index/dangKy";
        }
        if (sdt.length() != 10) {
            model.addAttribute("error", "Số điện thoại không hợp lệ.");
            return "index/dangKy";
        }
        if (matKhau.length() < 8) { // Sửa kiểm tra mật khẩu (ít nhất 8 ký tự)
            model.addAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự.");
            return "index/dangKy";
        } else {
            user = new User();
            user.setHo_va_ten(hovaten);
            user.setTen(ten);
            user.setMat_khau(matKhau);
            user.setDia_chi(diachi); // Gán giá trị địa chỉ
            user.setSDT(sdt);
            user.setEmail(email);
            user.setRole(1);
            userServiceImpl.saveUser(user); // Lưu người dùng mới vào cơ sở dữ liệu
            // Thêm thông báo thành công
            model.addAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
            return "index/dangNhap"; // Hiển thị lại trang đăng ký kèm thông báo
        }
    }

}