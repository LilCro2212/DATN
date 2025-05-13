package com.dan.datn.Service;

import com.dan.datn.Entity.Hinh;
import com.dan.datn.Repository.HinhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HinhService {

    @Autowired
    private HinhRepository hinhRepository;

    // Method to get the image object by its ID
    public Object getHinhById(Long id) {
        return hinhRepository.findById(id).orElse(null);
    }

    public Hinh saveImage(byte[] imageData) {
        Hinh hinh = new Hinh();
        hinh.setHinhMain(imageData);  // Gán hình ảnh vào trường hình chính
        return hinhRepository.save(hinh);  // Lưu và trả về đối tượng Hinh có ID
    }

    // Lưu nhiều hình ảnh (chính và phụ) và trả về đối tượng Hinh
    public Hinh saveMultipleImages(byte[] mainImage, byte[] hinh1, byte[] hinh2, byte[] hinh3, byte[] hinh4) {
        Hinh hinh = new Hinh();
        hinh.setHinhMain(mainImage);  // Gán hình chính
        hinh.setHinh1(hinh1);  // Gán hình phụ 1
        hinh.setHinh2(hinh2);  // Gán hình phụ 2
        hinh.setHinh3(hinh3);  // Gán hình phụ 3
        hinh.setHinh4(hinh4);  // Gán hình phụ 4
        return hinhRepository.save(hinh);  // Lưu vào DB và trả về đối tượng Hinh với ID
    }
}
