package com.dan.datn.Entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Base64;

@Entity
@Table(name = "Hinh")
@Getter
@Setter
public class Hinh {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Đây là cách tự động tăng (auto-increment)
    private Long ID_hinh;

    @Column(name = "Hinh_main", nullable = false)
    private byte[] hinhMain;

    @Column(name = "Hinh_1", nullable = false)
    private byte[] hinh1;

    @Column(name = "Hinh_2", nullable = false)
    private byte[] hinh2;

    @Column(name = "Hinh_3", nullable = false)
    private byte[] hinh3;

    @Column(name = "Hinh_4", nullable = false)
    private byte[] hinh4;


    @Transient
    private String base64Image;

    // Method to convert byte[] to base64 string
    public String encodeBase64(byte[] image) {
        return Base64.getEncoder().encodeToString(image);
    }

    // Get base64 representation for all images
    public String getBase64MainImage() {
        return this.hinhMain != null ? encodeBase64(this.hinhMain) : null;
    }


    public String getBase64Hinh1() {
        return encodeBase64(this.hinh1);
    }

    public String getBase64Hinh2() {
        return encodeBase64(this.hinh2);
    }

    public String getBase64Hinh3() {
        return encodeBase64(this.hinh3);
    }

    public String getBase64Hinh4() {
        return encodeBase64(this.hinh4);
    }
}
