package hostlermanager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hostlermanager.DAO.EmployeeDAO;
import hostlermanager.model.Employee;

@Service
public class EmployeeService {
	
	@Autowired
	private EmployeeDAO employeeDAO;
	
	public Employee empValidate(String email,String password) {
		
		return this.employeeDAO.empValidate(email, password);
	}
	
	public boolean permissionGrant(int id, int hostlerid, String empName, int empId) {
		
		return this.employeeDAO.permissionGrant(id ,hostlerid,empName,empId);
	}

}
