package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.ThanhToan;
import com.dan.datn.Entity.ThongKe;
import com.dan.datn.Repository.SanPhamRepository;
import com.dan.datn.Repository.ThanhToanRepository;
import com.dan.datn.Repository.ThongKeRepository;
import com.dan.datn.Repository.UserRepository;
import com.dan.datn.Service.ThanhToanService;
import com.dan.datn.dto.ProductDTO;
import com.dan.datn.dto.ThanhToanDTO;
import com.dan.datn.Event.OnRegistrationCompleteEvent;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class ThanhToanServiceImpl implements ThanhToanService {

    private final ThanhToanRepository thanhToanRepository;
    private final SanPhamRepository sanPhamRepository;
    private final UserRepository userRepository;
    private final ThongKeRepository thongKeRepository;
    private final ApplicationEventPublisher eventPublisher;

    @Transactional
    public void thanhToan(ThanhToanDTO request) {
        var user = userRepository.findByTen(request.getUserName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (request.getProducts() == null || request.getProducts().isEmpty()) {
            throw new IllegalArgumentException("No products in checkout request");
        }

        double tongTienDonHang = 0;
        List<ThanhToan> thanhToans = new ArrayList<>();

        for (ProductDTO productDTO : request.getProducts()) {
            var sanPham = sanPhamRepository.findById(productDTO.getId())
                    .orElseThrow(() -> new RuntimeException("Product not found with id: " + productDTO.getId()));

            if (sanPham.getSoLuongTonKho() < productDTO.getSoLuong()) {
                throw new RuntimeException("Không đủ số lượng sản phẩm " + sanPham.getTenSach() +
                        " trong kho. Chỉ còn " + sanPham.getSoLuongTonKho() + " sản phẩm.");
            }

            sanPham.setSoLuongDaBan(sanPham.getSoLuongDaBan() + productDTO.getSoLuong());
            sanPham.setSoLuongTonKho(sanPham.getSoLuongTonKho() - productDTO.getSoLuong());
            sanPham.setSoLuongTongSanPham(sanPham.getSoLuongTongSanPham() - productDTO.getSoLuong());
            sanPhamRepository.save(sanPham);

            double tongTienSanPham = productDTO.getGia() * productDTO.getSoLuong();
            tongTienDonHang += tongTienSanPham;

            ThanhToan thanhToan = ThanhToan.builder()
                    .phuongThucThanhToan(request.getPhuong_thuc_thanh_toan())
                    .soLuong(productDTO.getSoLuong())
                    .tongTien((int) tongTienSanPham)
                    .user(user)
                    .sanPham(sanPham)
                    .ngayDatHang(new Date())
                    .build();
            thanhToans.add(thanhToan);
        }

        try {
            thanhToanRepository.saveAll(thanhToans);

            List<ThongKe> thongKeList = new ArrayList<>();
            for (ThanhToan thanhToan : thanhToans) {
                // Kiểm tra nếu ID_thanh_toan là null
                if (thanhToan.getID_thanh_toan() == null) {
                    throw new RuntimeException("Lưu ThanhToan thất bại: ID chưa được tạo.");
                }

                // Tạo đối tượng ThongKe mới
                ThongKe thongKe = new ThongKe();

                // Gán đối tượng ThanhToan vào ThongKe
                thongKe.setThanhToan(thanhToan);

                // Làm tròn tongTien và chuyển về Integer
                int tongDoanhThu = (int) Math.round(thanhToan.getTongTien()); // Làm tròn giá trị

                // Gán giá trị doanh thu vào ThongKe
                thongKe.setTongDoanhThu(tongDoanhThu);

                // Thêm ThongKe vào danh sách thongKeList
                thongKeList.add(thongKe);
            }


            thongKeRepository.saveAll(thongKeList);

            eventPublisher.publishEvent(new OnRegistrationCompleteEvent(user));
        } catch (Exception e) {
//            throw new PaymentProcessingException("Lỗi khi xử lý thanh toán và thống kê", e);
        }
    }

    @Override
    public List<ThanhToan> getAllThanhToan() {
        return thanhToanRepository.findAll();
    }
}
