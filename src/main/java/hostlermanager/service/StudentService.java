package hostlermanager.service;

import java.util.Collection;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hostlermanager.DAO.StudentDao;
import hostlermanager.model.HostlerDetail;
import hostlermanager.model.Student;

@Service
public class StudentService {
	
	@Autowired
	private StudentDao studentDao;
	public int createStudent(Student student) {
		
		int i = this.studentDao.saveStudent(student);
		return i;
	}
	
	public Student existStudentOrNot(String email, String password) {
		return this.studentDao.existStudent(email, password);
	}
	
	public int saveHostlerDetail(HostlerDetail hostlerDetail) {
		
		int i =this.studentDao.saveHostler(hostlerDetail);
		return i;
	}
	
	public int updateGoStudent(HostlerDetail hostlerDetail,int id) {
		
		int i =this.studentDao.updateGoStudent(hostlerDetail,id);
		return i;
	}

	public List<HostlerDetail>  showall(int id,String user) {
		
		List<HostlerDetail> result = this.studentDao.showall(id,user);
		Collections.reverse(result);
		return result;
	}
}
