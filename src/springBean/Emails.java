package springBean;

import java.io.File;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

/**
 * @author Sistemas
 * 
 */
@Service
public class Emails {

    private JavaMailSender mailSender;

    @Autowired
    public Emails(JavaMailSender mailSender) {
	super();
	this.mailSender = mailSender;
    }

    /**
     * @param from
     *            String mail from.
     * @param subject
     *            String mail subject.
     * @param listRecipient
     *            List&lt;String&gt; mail recipient.
     * @param message
     *            String mail message
     * @param listAttach
     *            List&lt;String&gt; mail attach.
     * @throws MessagingException
     *             It happens when the properties aren't loaded.
     */
    public void sendMail(String from, String subject, List<String> listRecipient, String message, List<File> listAttachFile) {
	MimeMessage msg = mailSender.createMimeMessage();
	try {
	    MimeMessageHelper helper = new MimeMessageHelper(msg, true);
	    helper.setFrom(from);
	    helper.setSubject(subject);
	    /* Convert list to array */
	    String[] to = listRecipient.toArray(new String[listRecipient.size()]);
	    helper.setTo(to);
	    helper.setText(message);
	    if (listAttachFile != null) {
		for (File file : listAttachFile) {
		    helper.addAttachment(file.getName(), file);
		}
	    }
	} catch (MessagingException e) {
	    throw new MailParseException(e);
	}
	mailSender.send(msg);
    }
}
