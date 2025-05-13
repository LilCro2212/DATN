package com.dan.datn.Controller;

import com.dan.datn.Entity.User;
import com.dan.datn.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Optional;

@Controller
@RequestMapping("/api") // Đường dẫn gốc cho API
public class ThongTinCaNhanApiController {

    @Autowired
    private UserService userService;

    @GetMapping("/thongtincanhan")
    @ResponseBody
    public ResponseEntity<?> getThongTinCaNhan(HttpSession session) {
        // Lấy username từ session
        String username = (String) session.getAttribute("username");

        if (username == null) {
            // Nếu chưa đăng nhập, trả về lỗi 401 (Unauthorized)
            return ResponseEntity.status(401).body("Bạn vui lòng đăng nhập trước khi truy cập trang cá nhân.");
        }

        // Tìm người dùng theo tên
        Optional<User> userOptional = userService.getUserByTen(username);

        // Kiểm tra nếu tìm thấy người dùng
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return ResponseEntity.ok(user); // Trả về thông tin người dùng dưới dạng JSON
        } else {
            // Trả về lỗi 404 nếu không tìm thấy người dùng
            return ResponseEntity.status(404).body("Người dùng không tồn tại.");
        }
    }
}
