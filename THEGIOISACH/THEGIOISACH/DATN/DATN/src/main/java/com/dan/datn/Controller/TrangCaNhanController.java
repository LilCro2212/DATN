package com.dan.datn.Controller;

import com.dan.datn.Entity.User;
import com.dan.datn.Service.ServiceImpl.UserServiceImpl;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@SessionAttributes("username")
@Controller
public class TrangCaNhanController {
    private final UserServiceImpl userServiceImpl;

    public TrangCaNhanController(UserServiceImpl userServiceImpl) {
        this.userServiceImpl = userServiceImpl;
    }

    @GetMapping("/trangcanhan")
    public String trangCaNhan(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");

        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập trang cá nhân.");
            return "index/dangNhap";
        }

        model.addAttribute("username", username);
        return "index/trangCaNhan";
    }

    @GetMapping("/thongtintaikhoan")
    public String getThongTinCaNhan(HttpSession session, Model model) {
//        String username = (String) session.getAttribute("username");
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);

        if (username == null) {
            model.addAttribute("error", "Bạn vui lòng đăng nhập trước khi truy cập thông tin cá nhân.");
            return "index/dangNhap";
        }

        Optional<User> userOptional = userServiceImpl.getUserByTen(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            model.addAttribute("user", user);
        } else {
            model.addAttribute("error", "Người dùng không tồn tại.");
        }

        return "layout/Thongtincanhan";
    }



    // New method for updating user information
    @PostMapping("/updateUser")
    public String updateUser(
            @RequestParam("hovaten") String hovaten,
            @RequestParam("phone") String phone,
            @RequestParam("email") String email,
            @RequestParam("diachi") String diachi,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        String username = (String) session.getAttribute("username");

        if (username == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng đăng nhập trước khi cập nhật thông tin cá nhân.");
            return "redirect:/login";
        }

// Kiểm tra từng trường hợp cụ thể
        if (phone == null || phone.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng nhập số điện thoại.");
            return "redirect:/thongtintaikhoan";
        }

        if (email == null || email.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng nhập email.");
            return "redirect:/thongtintaikhoan";
        }

        if (diachi == null || diachi.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng nhập địa chỉ.");
            return "redirect:/thongtintaikhoan";
        }

        if (hovaten == null || hovaten.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng nhập tên.");
            return "redirect:/thongtintaikhoan";
        }
        Optional<User> userOptional = userServiceImpl.getUserByTen(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            // Kiểm tra xem thông tin có thay đổi hay không
            boolean isChanged = false;

            if (!user.getHo_va_ten().equals(hovaten)) {
                user.setHo_va_ten(hovaten);
                isChanged = true;
            }
            if (!user.getSDT().equals(Integer.valueOf(phone))) {
                user.setSDT(phone);
                isChanged = true;
            }
            if (!user.getEmail().equals(email)) {
                user.setEmail(email);
                isChanged = true;
            }
            if (!user.getDia_chi().equals(diachi)) {
                user.setDia_chi(diachi);
                isChanged = true;
            }

            // Nếu không có thay đổi gì
            if (!isChanged) {
                redirectAttributes.addFlashAttribute("error", "Chưa phát hiện thay đổi nào.");
                return "redirect:/thongtintaikhoan";
            }

            // Lưu thông tin mới nếu có thay đổi
            try {
                userServiceImpl.saveUser(user);
                redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin thành công!");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Đã xảy ra lỗi khi cập nhật thông tin.");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại.");
        }

        return "redirect:/thongtintaikhoan";
    }

    @PostMapping("/updatePassword")
    public String updatePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Lấy thông tin username từ session
        String username = (String) session.getAttribute("username");

        if (username == null) {
            redirectAttributes.addFlashAttribute("error", "Bạn vui lòng đăng nhập trước khi cập nhật mật khẩu.");
            return "redirect:/login";
        }

        // Kiểm tra các trường hợp lỗi liên quan đến mật khẩu
        if (oldPassword.isEmpty() && newPassword.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ và mật khẩu mới không được để trống.");
            return "redirect:/thongtintaikhoan";
        }
        if (oldPassword == null || oldPassword.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ không được để trống.");
            return "redirect:/thongtintaikhoan";
        }
        if (newPassword == null || newPassword.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu mới không được để trống.");
            return "redirect:/thongtintaikhoan";
        }
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng nhập lại mật khẩu mới để xác nhận.");
            return "redirect:/thongtintaikhoan";
        }

        // Kiểm tra độ dài của mật khẩu mới
        if (newPassword.length() < 8) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu mới phải có ít nhất 8 ký tự.");
            return "redirect:/thongtintaikhoan";
        }

        // Kiểm tra nếu mật khẩu mới và mật khẩu cũ giống nhau
        if (oldPassword.equals(newPassword)) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu mới không thể giống mật khẩu cũ.");
            return "redirect:/thongtintaikhoan";
        }

        // Kiểm tra nếu mật khẩu mới và xác nhận mật khẩu không trùng khớp
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không trùng khớp.");
            return "redirect:/thongtintaikhoan";
        }

        // Kiểm tra mật khẩu cũ có chính xác không
        Optional<User> userOptional = userServiceImpl.getUserByTen(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();

            if (!user.getMat_khau().equals(oldPassword)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu cũ không chính xác.");
                return "redirect:/thongtintaikhoan";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại.");
            return "redirect:/thongtintaikhoan";
        }

        // Cập nhật mật khẩu qua service
        boolean success = userServiceImpl.updatePassword(username, oldPassword, newPassword, confirmPassword);

        if (!success) {
            redirectAttributes.addFlashAttribute("error", "Không thể cập nhật mật khẩu. Vui lòng thử lại.");
            return "redirect:/thongtintaikhoan";
        }

        redirectAttributes.addFlashAttribute("success", "Cập nhật mật khẩu thành công!");
        return "redirect:/thongtintaikhoan";
    }



}
