package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.Date;

@Entity
@Table(name = "Danh_Gia")
@Getter
@Setter
public class DanhGia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_danh_gia;

    @Column(name = "Ngay_danh_gia", nullable = false)
    private Date ngayDanhGia;

    @Column(name = "Danh_gia", nullable = false)
    private Integer danhGia;

    @Column(name = "Binh_luan", nullable = false)
    private String binhLuan;

    // Relationships
    @ManyToOne
    @JoinColumn(name = "ID_nguoi_dung", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "ID_san_pham", nullable = false)
    private SanPham sanPham;
}


