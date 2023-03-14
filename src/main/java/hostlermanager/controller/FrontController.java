package hostlermanager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import hostlermanager.model.Student;
import hostlermanager.service.StudentService;

@Controller
public class FrontController {

	@Autowired
	private StudentService studentService;
	private HttpSession session;

	@RequestMapping(path="/login")
	public String login(HttpServletRequest request) {
		session = request.getSession();
		session.invalidate();
		return "login";
	}
	
	@RequestMapping("/signin")
	public String signup() {
		return "signin";
	}
	
	@RequestMapping(path="/home")
	public String home(HttpServletRequest request) {
		session = request.getSession();
		
		if(session.getAttribute("sid") != null && session.getAttribute("suser") == "student") {
			Student s = (Student)session.getAttribute("student");
			Student student = this.studentService.existStudentOrNot(s.getEmail(), s.getPassword());
			session.setAttribute("student",student);	
			
			return "home";
		}
		else return "login";
	}
	
	
}
