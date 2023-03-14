package hostlermanager.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import hostlermanager.model.HostlerDetail;
import hostlermanager.service.StudentService;

@Controller
public class ShowallController {

	@Autowired
	private StudentService studentService;
	private HttpSession session;
	
	
	@RequestMapping("/showall")
	public String showall(HttpServletRequest request) {
		session = request.getSession();
		String sid = String.valueOf(session.getAttribute("sid"));
		if(sid == "null") return "redirect:/login";
		int id = Integer.valueOf(sid);
		List<HostlerDetail> result = this.studentService.showall(id,"student");
		session.setAttribute("listAllActivity", result);
		return "showall";
	}
	
	@RequestMapping("/empshowall")
	public String empshowall(HttpServletRequest request) {
		session = request.getSession();
		String eid = String.valueOf(session.getAttribute("eid"));
		if(eid == "null") return "redirect:/emplogin";
		int id = Integer.valueOf(eid);
		List<HostlerDetail> result = this.studentService.showall(id,"employee");
		session.setAttribute("listAllActivity", result);
		return "empshowall";
	}
	
	@RequestMapping(path="/logOutUser")
	public String logOutUser(HttpServletRequest request) {
		session = request.getSession(false);
	    if (session != null) {
	    	String user = (String)session.getAttribute("user");
	        session.invalidate();
	        if(user == "employee") return "redirect:/emplogin";
	    }
	    return "redirect:/login";
	}
}


