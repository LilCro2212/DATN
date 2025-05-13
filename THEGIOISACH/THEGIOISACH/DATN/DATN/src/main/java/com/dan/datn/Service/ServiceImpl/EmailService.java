package com.dan.datn.Service.ServiceImpl;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {
    public void sendEmail(String to, String subject, String body) {
        // Thay bằng logic gửi email thực tế
        System.out.println("Gửi email đến: " + to);
        System.out.println("Tiêu đề: " + subject);
        System.out.println("Nội dung: " + body);
    }

    private final JavaMailSender mailSender;
    /**
     * Sends a verification email to the specified recipient.
     *
     * @param to              the recipient's email address
     * @param username       the username of the recipient


     * @throws MessagingException if an error occurs while sending the email
     */
    public void sendVerificationEmail(String to, String username) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setTo(to);
        helper.setSubject("Email Verification");
        helper.setText(generateVerificationEmailContent(username), true);

        mailSender.send(message);
    }

    /**
     * Generates the HTML content for the verification email.
     *
     * @param username       the username of the recipient


     * @return a String containing the HTML content for the email
     */
    private String generateVerificationEmailContent(String username) {
        return "<!DOCTYPE html>"
                + "<html lang=\"en\">"
                + "<head>"
                + "<meta charset=\"UTF-8\">"
                + "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
                + "<title>Thank You for Your Purchase</title>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }"
                + ".container { width: 100%; padding: 20px; background-color: #f4f4f4; }"
                + ".email-content { max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }"
                + ".header { text-align: center; background-color: #28a745; color: #ffffff; padding: 10px 0; border-radius: 5px 5px 0 0; }"
                + ".header h1 { margin: 0; font-size: 24px; }"
                + ".body { padding: 20px; text-align: center; }"
                + ".body p { font-size: 16px; color: #333333; line-height: 1.5; }"
                + ".body a { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #28a745; color: #ffffff; text-decoration: none; border-radius: 5px; }"
                + ".footer { text-align: center; margin-top: 20px; color: #777777; font-size: 12px; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class=\"container\">"
                + "<div class=\"email-content\">"
                + "<div class=\"header\">"
                + "<h1>Thank You for Your Purchase!</h1>"
                + "</div>"
                + "<div class=\"body\">"
                + "<p>Hello " + username+ ",</p>"
                + "<p>Thank you for your recent purchase with us! We're thrilled to have you as a customer, and we hope you enjoy your new products.</p>"
                + "<p>If you have any questions or need assistance, don't hesitate to reach out to our customer service team.</p>"
                + "<p>We look forward to serving you again in the future!</p>"
                + "<p>Best regards,</p>"
                + "<p>Your friends at MyApp</p>"
                + "</div>"
                + "<div class=\"footer\">"
                + "<p>&copy; 2024 MyApp. All rights reserved.</p>"
                + "</div>"
                + "</div>"
                + "</div>"
                + "</body>"
                + "</html>";

    }
}
