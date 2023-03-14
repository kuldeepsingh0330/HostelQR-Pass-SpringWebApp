package hostlermanager.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.mysql.cj.Session;

import hostlermanager.model.HostlerDetail;
import hostlermanager.model.Student;
import hostlermanager.service.StudentService;

@Controller
public class FromController {

	@Autowired
	private StudentService studentService;
	HttpSession session;

	@RequestMapping(path = "/validate", method = RequestMethod.POST)
	public String validate(HttpServletRequest request, @RequestParam("email") String email, @RequestParam("password") String password) {
		Student student = this.studentService.existStudentOrNot(email, password);
		if (student != null) {
			session = request.getSession();
			session.setAttribute("student", student);
			session.setAttribute("sid", student.getId());
			session.setAttribute("name", student.getName());
			session.setAttribute("email",student.getEmail());
			session.setAttribute("isInside",student.isInside());
			session.setAttribute("suser","student");
			if(student.getHostlerDetail() != null) 
				session.setAttribute("hostlerID", student.getHostlerDetail().getId());
			return "redirect:home";
		} else
			return "redirect:login";
	}

	@RequestMapping(path = "/signin", method = RequestMethod.POST)
	public String signup(@ModelAttribute Student student, HttpServletRequest request) {		
		int i = this.studentService.createStudent(student);
		if(i == 0) {
			request.setAttribute("email_exist", "Email Already exist");
			return "signin";
		}
		return "redirect:login";
	}

	@RequestMapping(path = "/generateQRCon", method = RequestMethod.POST)
	public String generateQRCon(HttpServletRequest request, @ModelAttribute HostlerDetail hostlerDetail) {		
		session = request.getSession(false);
		session.setAttribute("isInside", true);
		int id = (Integer) session.getAttribute("sid");	
		Student student = (Student) session.getAttribute("student");
		hostlerDetail.setStudent(student);
		int i = this.studentService.saveHostlerDetail(hostlerDetail);
		int j = this.studentService.updateGoStudent(hostlerDetail,id);
		session.setAttribute("hostlerID", hostlerDetail.getId());

		return "redirect:home";

	}
}
