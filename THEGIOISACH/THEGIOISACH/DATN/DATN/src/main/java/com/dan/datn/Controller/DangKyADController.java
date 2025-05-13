package com.dan.datn.Controller;

import com.dan.datn.Entity.User;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class DangKyADController {

    @Autowired
    private UserServiceImpl userServiceImpl;

    @GetMapping("/taomoi")
    public String taomoi(Model model, HttpSession session) {
        model.addAttribute("user", new User()); // Đối tượng để tạo mới admin
        List<User> adminList = userServiceImpl.getAllAdmins(); // Lấy danh sách admin hiện có
        model.addAttribute("adminList", adminList);
        return "index/TaoMoi";
    }

    @PostMapping("/dangkyadmin")
    public String registerAdmin(@ModelAttribute("user") User user, Model model,
                                @RequestParam String ten,
                                @RequestParam String matKhau,
                                @RequestParam String diachi,
                                @RequestParam String sdt,
                                @RequestParam("confirm-password") String confirmPassword,
                                @RequestParam String email,
                                @RequestParam String hovaten, RedirectAttributes redirectAttributes) {

        try {
            if (!sdt.startsWith("0") ) {
                model.addAttribute("error", "Số điện thoại phải bắt đầu bằng số 0.");
                return "index/dangKy";
            }
            if (userServiceImpl.istenExist(ten)) {
                redirectAttributes.addFlashAttribute("error", "Tên này đã được đăng ký.");
                return "redirect:/taomoi";
            }

            // Kiểm tra các điều kiện lỗi
            if (ten == null || ten.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Tên đăng nhập không được để trống.");
                return "redirect:/taomoi";
            }

            if (userServiceImpl.isPhoneExist(sdt)) {
                redirectAttributes.addFlashAttribute("error", "Số điện thoại này đã được đăng ký.");
                return "redirect:/taomoi";
            }

            if (userServiceImpl.isEmailExist(email)) {
                redirectAttributes.addFlashAttribute("error", "Email này đã được đăng ký.");
                return "redirect:/taomoi";
            }

            if (!matKhau.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu và xác nhận mật khẩu không trùng khớp.");
                return "redirect:/taomoi";
            }

            if (sdt.length() != 10) {
                redirectAttributes.addFlashAttribute("error", "Số điện thoại không hợp lệ.");
                return "redirect:/taomoi";
            }

            if (matKhau.length() < 8) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu phải có ít nhất 8 chữ cái.");
                return "redirect:/taomoi";
            }

            // Lưu admin mới nếu không có lỗi
            user = new User();
            user.setHo_va_ten(hovaten);
            user.setTen(ten);
            user.setMat_khau(matKhau);
            user.setDia_chi(diachi);
            user.setSDT(sdt);
            user.setEmail(email);
            user.setRole(0);  // Đặt role cho admin
            userServiceImpl.saveAdmin(user);  // Lưu admin mới vào cơ sở dữ liệu

            // Thông báo thành công
            model.addAttribute("success", "Đăng ký admin thành công! Bạn có thể đăng nhập ngay bây giờ.");
            return "index/LoginAdmin";  // Chuyển hướng đến trang đăng nhập admin

        } catch (Exception e) {
            // Log lỗi chi tiết nếu có ngoại lệ
            e.printStackTrace();
            model.addAttribute("error", "Đã có lỗi xảy ra, vui lòng thử lại.");
            return "redirect:/taomoi";  // Quay lại trang tạo admin
        }
    }

}
