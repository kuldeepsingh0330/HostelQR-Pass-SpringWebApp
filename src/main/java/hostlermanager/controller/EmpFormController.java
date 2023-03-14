package hostlermanager.controller;

import java.net.http.HttpRequest;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hostlermanager.model.Employee;
import hostlermanager.service.EmployeeService;

@Controller
public class EmpFormController {
	
	@Autowired
	private EmployeeService employeeService;
	private HttpSession session;
	
	@RequestMapping("/emplogin")
	public String emplogin(HttpServletRequest request) {
		session = request.getSession(false);
		session.invalidate();
		return "emplogin";
	}
	
	@RequestMapping(path="/empvalidate", method = RequestMethod.POST)
	public String empvalidate(@RequestParam("empEmail") String empEmail,@RequestParam("empPassword") String empPassword, HttpServletRequest request) {
		Employee employee = this.employeeService.empValidate(empEmail,empPassword);
		if(employee != null) {
			session = request.getSession();
			session.setAttribute("eid", employee.getId());
			session.setAttribute("empName", employee.getName());
			session.setAttribute("empEmail", employee.getEmail());
			session.setAttribute("euser","employee");
			
			return "redirect:emphome";
		}
		return "redirect:emplogin";
	}
	
	@RequestMapping("/emphome")
	public String emphome(HttpServletRequest request) {
		session = request.getSession();
		if(session.getAttribute("eid") != null && session.getAttribute("euser") == "employee")
			return "emphome";
		else return "redirect:emplogin";
	}

	
	@RequestMapping(path="/permissionGarant" , method = RequestMethod.POST)
	public @ResponseBody String permissionGarant(@RequestParam("myVar") String data , HttpServletRequest request) {
		String[] val = data.split("/",2);
		session = request.getSession();
		int empId = (Integer)session.getAttribute("eid");
		String empName = (String)session.getAttribute("empName");
		int hostlerid = Integer.valueOf(val[0]);
		int  id = Integer.valueOf(val[1]);
		boolean isGranted = this.employeeService.permissionGrant(id,hostlerid,empName,empId);
		return isGranted?"true":"false";
	}
	

}
