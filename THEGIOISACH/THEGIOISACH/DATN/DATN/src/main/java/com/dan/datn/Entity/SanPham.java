package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "San_Pham")
@Getter
@Setter
public class SanPham {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_san_pham;

    @Column(name = "Nha_xuat_ban", nullable = false)
    private String nhaXuatBan;

    @Column(name = "NSX", nullable = false)
    private Date nsx;

    @Column(name = "Ten_sach", nullable = false)
    private String tenSach;

    @Column(name = "Tac_gia", nullable = false)
    private String tacGia;

    @Column(name = "Gia", nullable = false)
    private Integer gia;

    @Column(name = "So_luong_da_ban")
    private Integer soLuongDaBan;

    @Column(name = "So_luong_ton_kho", nullable = false)
    private Integer soLuongTonKho;

    @Column(name = "So_luong_tong_san_pham", nullable = false)
    private Integer soLuongTongSanPham;

    @Column(name = "Mo_ta", nullable = false)
    private String moTa;


    // Relationships
    @ManyToOne
    @JoinColumn(name = "ID_the_loai", nullable = false)
    private TheLoai theLoai;

    @OneToOne
    @JoinColumn(name = "ID_hinh", nullable = false)
    private Hinh hinh;

    @OneToMany(mappedBy = "sanPham")
    private List<DanhGia> danhGiaList;

//    @OneToMany(mappedBy = "sanPham")
//    private List<HoaDonChiTiet> hoaDonChiTietList;

}
