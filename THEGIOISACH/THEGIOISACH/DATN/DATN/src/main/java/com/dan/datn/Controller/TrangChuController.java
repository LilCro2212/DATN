package com.dan.datn.Controller;

import com.dan.datn.Entity.SanPham;

import com.dan.datn.Service.ServiceImpl.SanPhamServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Base64;
import java.util.List;
import jakarta.servlet.http.HttpSession;


@Controller
public class TrangChuController {

    @Autowired
    private SanPhamServiceImpl sanPhamServiceImpl;
    @Autowired
    private HttpSession session;

    @GetMapping("/trangchu")
    public String showTrangChu(Model model){
        // Lấy sản phẩm theo khoảng danh sách ID
        List<SanPham> sanphamsNoiBat = sanPhamServiceImpl.getSanPhamByIdRange();

        // Lấy sản phẩm theo danh sách ID cụ thể

        // Chuyển đổi hình ảnh sang Base64
        for (SanPham sp : sanphamsNoiBat) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }
        model.addAttribute("sanphamsNoiBat", sanphamsNoiBat);

        List<SanPham> sanphamsTheLoai = sanPhamServiceImpl.getSanPhamBySpecificIds();
        for (SanPham sp : sanphamsTheLoai) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }
        model.addAttribute("sanphamsTheLoai", sanphamsTheLoai);

        // Lấy 6 sản phẩm ngẫu nhiên
        List<SanPham> SanPhamSanPhams = sanPhamServiceImpl.getSanPhamSanPham(36);
        for (SanPham sp : SanPhamSanPhams) {
            if (sp.getHinh() != null && sp.getHinh().getHinhMain() != null) {
                String base64Image = Base64.getEncoder().encodeToString(sp.getHinh().getHinhMain());
                sp.getHinh().setBase64Image(base64Image);
            }
        }
        model.addAttribute("SanPhamSanPhams", SanPhamSanPhams);

        // Lấy username từ session
        String username = (String) session.getAttribute("username");
        model.addAttribute("username", username);
        return "index/trangChu";
    }


    @GetMapping ("/dangnhap")
    public String showDangNhap(){
        return "index/dangNhap";
    }

    @GetMapping ("/dangkytaikhoan")
    public String showDangKy(){
        return "index/dangKy";
    }


    @GetMapping("/quenmatkhau")
    public String getQuenMatKhau() {
        return "index/datLaiMatKhau";
    }

    @GetMapping("/cauhoithuonggap")
    public String showCauHoiThuongGap(){
        return "index/cauHoiThuongGap";
    }

    @GetMapping("/chamsockhachhang")
    public String showChamSocKhachHang(){
        return "index/chamSocKhachHang";
    }

    @GetMapping("/chinhsachbaomat")
    public String showChinhSachBaoMat(){
        return "index/chinhSacBaoMat";
    }

    @GetMapping("/dieukhoan")
    public String showDieuKhoan(){
        return "index/dieuKhoan";
    }

    @GetMapping("/chinhsachdoitra")
    public String showChinhSachDoiTra(){
        return "index/chinhSachDoiTra";
    }

    @GetMapping("/chinhsachvanchuyen")
    public String showChinhSachVanChuyen(){
        return "index/chinhSachVanChuyen";
    }

    @GetMapping("/huongdanmuahang")
    public String showHuongDanMuaHang(){
        return "index/huongDanMuaHang";
    }

    @GetMapping("/hotrokhachhang")
    public String showHoTroKhachHang(){return "index/HoTroKhachHang";
    }
}

