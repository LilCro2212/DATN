package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "Thanh_Toan")
@Getter
@Setter
@Builder
@AllArgsConstructor
@RequiredArgsConstructor
public class ThanhToan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_thanh_toan;

    @Column(name = "Ngay_dat_hang", nullable = false)
    private Date ngayDatHang;

    @Column(name = "Tong_tien", nullable = false)
    private Integer tongTien;

    @Column(name = "Phuong_thuc_thanh_toan", nullable = false)
    private String phuongThucThanhToan;

    @Column(name = "So_luong", nullable = false)
    private Integer soLuong;

    // Relationships

    @ManyToOne
    @JoinColumn(name = "ID_nguoi_dung", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "ID_san_pham", nullable = false)
    private SanPham sanPham;

}
