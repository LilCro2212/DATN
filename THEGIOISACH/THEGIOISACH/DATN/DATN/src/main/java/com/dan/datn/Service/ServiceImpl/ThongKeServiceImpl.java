package com.dan.datn.Service.ServiceImpl;

import com.dan.datn.Entity.ThongKe;
import com.dan.datn.Repository.ThongKeRepository;
import com.dan.datn.Service.ThongKeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThongKeServiceImpl extends ThongKeService {

    @Autowired
    private ThongKeRepository thongKeRepository;

    @Override
    public List<ThongKe> getAllThongKe() {
        return thongKeRepository.findAll();
    }
}
