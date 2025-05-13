package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.TheLoai;
import com.dan.datn.Repository.TheLoaiRepository;
import com.dan.datn.Service.TheLoaiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TheLoaiServiceImpl implements TheLoaiService {

    @Autowired
    private TheLoaiRepository theLoaiRepository;
    @Override
    public TheLoai findByCategoryName(String categoryName) {
        return theLoaiRepository.findByTheLoai(categoryName);
    }
}
