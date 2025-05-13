package com.dan.datn.Controller;

import com.dan.datn.Service.MatKhauService;
import com.dan.datn.Service.VerificationCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MatKhauController {

    @Autowired
    private MatKhauService matKhauService;

    @Autowired
    private VerificationCodeService verificationCodeService;

    // Hiển thị trang quên mật khẩu
    @GetMapping("/quen-mat-khau")
    public String showQuenMatKhauPage() {
        return "index/quenMatKhau";
    }

    // Xử lý gửi mã xác nhận quên mật khẩu
    @PostMapping("/quen-mat-khau")
    public String xuLyQuenMatKhau(@RequestParam("email") String email, Model model) {
        boolean isEmailExist = matKhauService.kienTraEmail(email);
        if (!isEmailExist) {
            model.addAttribute("error", "Email không tồn tại trong hệ thống.");
            return "index/quenMatKhau";
        }

        // Tạo và gửi mã xác nhận
        String verificationCode = matKhauService.guiMaXacNhan(email);

        // Lưu mã xác nhận vào bộ nhớ tạm thời
        verificationCodeService.sendVerificationCode(email, verificationCode);

        model.addAttribute("message", "Mã xác nhận đã được gửi tới email của bạn.");
        model.addAttribute("email", email); // Lưu email vào model để truyền qua trang "Đặt lại mật khẩu"
        return "index/datLaiMatKhau"; // Chuyển đến trang nhập mã xác nhận và đặt lại mật khẩu
    }

    // Xử lý việc đặt lại mật khẩu
    @PostMapping("/dat-lai-mat-khau")
    public String datLaiMatKhau(@RequestParam("email") String email,
                                @RequestParam("ma_xac_nhan") String maXacNhan,
                                @RequestParam("mat_khau_moi") String matKhauMoi, Model model) {

        // Kiểm tra mã xác nhận nhập vào có hợp lệ không
        boolean isCodeValid = verificationCodeService.verifyCode(email, maXacNhan);
        if (!isCodeValid) {
            model.addAttribute("error", "Mã xác nhận không hợp lệ hoặc đã hết hạn.");
            return "index/datLaiMatKhau"; // Nếu mã xác nhận không hợp lệ, quay lại trang nhập mã xác nhận
        }

        // Cập nhật mật khẩu mới
        boolean isSuccess = matKhauService.datLaiMatKhau(email, matKhauMoi, maXacNhan);

        if (!isSuccess) {
            model.addAttribute("error", "Đặt lại mật khẩu thất bại.");
            return "index/datLaiMatKhau"; // Nếu không cập nhật được mật khẩu, thông báo lỗi và quay lại trang đặt lại mật khẩu
        }

        model.addAttribute("message", "Mật khẩu đã được thay đổi thành công.");
        return "index/dangNhap"; // Thành công, chuyển về trang đăng nhập
    }
}
