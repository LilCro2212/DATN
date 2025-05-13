package com.dan.datn.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "Nguoi_Dung")
@Getter
@Setter
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID_nguoi_dung;

    @Column(name = "Ten")
    private String ten;

    @Column(name = "Ho_va_Ten")
    private String Ho_va_ten;

    @Column(name = "SDT")
    private String SDT;

    @Column(name = "Dia_chi")
    private String Dia_chi;

    @Column(name = "Mat_khau")
    private String Mat_khau;

    @Column(name = "Email")
    private String email;

    @Column(name = "Role", nullable = false)
    private int role = 1; // Default role set to 1

    // Relationships
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore // Không đưa danh sách đánh giá vào JSON trả về
    private List<DanhGia> danhGiaList;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore // Không đưa danh sách thanh toán vào JSON trả về
    private List<ThanhToan> thanhToanList;
}
