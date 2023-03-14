package hostlermanager.DAO;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.HeuristicMixedException;
import javax.transaction.HeuristicRollbackException;
import javax.transaction.RollbackException;
import javax.transaction.SystemException;
import javax.transaction.TransactionManager;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import hostlermanager.model.HostlerDetail;
import hostlermanager.model.Student;

@Repository
public class StudentDao {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	@Autowired
	private SessionFactory sessionFactory;
	private Session currentSession;
	
	@Transactional
	public int saveStudent(Student student) {
		currentSession = sessionFactory.openSession();
		String hql = "FROM Student s WHERE s.email = :email";
        Query query = currentSession.createQuery(hql);
        query.setParameter("email", student.getEmail());
        List<Student> results = query.list();
        if(results.size() != 0) return 0;
		int i = (Integer)this.hibernateTemplate.save(student);
		return i;
	}
	
	public Student existStudent(String email, String password) {
        currentSession = sessionFactory.openSession();
        
        String hql = "FROM Student s WHERE s.email = :email AND s.password = :password";
        Query query = currentSession.createQuery(hql);
        query.setParameter("email", email);
        query.setParameter("password", password);
        List<Student> results = query.list();
        if (results.size() >= 1) {
            return results.get(0);
        }
        return null;
	}

	@Transactional
	public int saveHostler(HostlerDetail hostlerDetail) {
		int i = (Integer) this.hibernateTemplate.save(hostlerDetail);
		return i;
	}
	
	@Transactional
	public int updateGoStudent(HostlerDetail hostlerDetail, int studentId) {
		currentSession = sessionFactory.getCurrentSession();
		String hql = "UPDATE Student s SET s.isInside = :truee,s.hostlerDetail = :hostlerDetail WHERE s.id = :studentId";
		Query query = currentSession.createQuery(hql);
		query.setParameter("truee", true);
		query.setParameter("hostlerDetail", hostlerDetail);
		query.setParameter("studentId", studentId);
		int result = query.executeUpdate();
		return result;
	}

	@Transactional
	public List<HostlerDetail>  showall(int id,String user) {
		if(user == "student") {
			Student s = new Student();
			s.setId(id);
			currentSession = sessionFactory.getCurrentSession();
			String hql= "FROM HostlerDetail h where h.student = :id";
			Query query = currentSession.createQuery(hql);
			query.setParameter("id", s);
			List<HostlerDetail> result = query.list();
			return result;
		}else if(user == "employee"){
			currentSession = sessionFactory.getCurrentSession();
			String hql= "FROM HostlerDetail h where h.empId = :id";
			Query query = currentSession.createQuery(hql);
			query.setParameter("id", id);			
			List<HostlerDetail> result = query.list();
			System.out.println(result.size()+"cbjsccsjccckshckj");
			return result;
		}else {
			return new ArrayList<HostlerDetail>();
		}
	}
}
