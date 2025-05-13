package com.dan.datn.Event;

import com.dan.datn.Entity.User;
import com.dan.datn.Service.ServiceImpl.EmailService;
import jakarta.mail.MessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

@Component
public class EmailSend implements ApplicationListener<OnRegistrationCompleteEvent> {
    @Autowired
    private EmailService emailService;
    @Override
    public void onApplicationEvent(OnRegistrationCompleteEvent event) {
        this.confirmRegistration(event);
    }
    private void confirmRegistration(OnRegistrationCompleteEvent event) {
        User user = event.getUser();
        String recipientAddress = user.getEmail();
        try {
            emailService.sendVerificationEmail(recipientAddress, user.getTen());
        } catch (MessagingException e) {
            // Handle the exception (log it, notify the user, etc.)
            e.printStackTrace();
        }
    }
}
