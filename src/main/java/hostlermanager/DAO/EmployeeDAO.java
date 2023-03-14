package hostlermanager.DAO;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.tomcat.jni.Time;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import hostlermanager.model.Employee;
import hostlermanager.model.HostlerDetail;
import hostlermanager.model.Student;

@Repository
public class EmployeeDAO {
	
	@Autowired
	private HibernateTemplate hibernateTemplate;
	@Autowired
	private SessionFactory sessionFactory;
	private Session currentSession;

	public Employee empValidate(String email,String password) {
        currentSession = sessionFactory.openSession();
        
        String hql = "FROM Employee e WHERE e.email = :email AND password = :password";
        Query query = currentSession.createQuery(hql);
        query.setParameter("email", email);
        query.setParameter("password", password);
        List<Employee> results = query.list();
        if (results.size() >= 1) {
            return results.get(0);
        }
        return null;
	}

	@Transactional
	public boolean permissionGrant(int id,int hostlerid, String empName, int empId) {
		currentSession = sessionFactory.getCurrentSession();
		String selectStd = "FROM HostlerDetail s WHERE s.id = :id";
		Query queryStd = currentSession.createQuery(selectStd);
		queryStd.setParameter("id", hostlerid);
		List<HostlerDetail> result = queryStd.list();
		HostlerDetail hostlerDetail= result.get(0);
		if(!hostlerDetail.isOutside()) {
			currentSession = sessionFactory.getCurrentSession();
			String hql = "UPDATE HostlerDetail h SET h.isOutside = :isOutside, h.isPermissionGranted = :grant, h.grantedByempName = :empName, h.empId = :empId, h.grantTime = :grantTime WHERE h.id = :data ";
			Query query = currentSession.createQuery(hql);
			query.setParameter("isOutside", true);
			query.setParameter("grant", true);
			query.setParameter("empName", empName);
			query.setParameter("empId", empId);
			query.setParameter("grantTime", new Date());
			query.setParameter("data", hostlerid);
			
			int resulthql = query.executeUpdate();
			if(resulthql != 0) return true;
			return false;
		}else {
			currentSession = sessionFactory.getCurrentSession();
			String updateStd = "UPDATE Student s SET s.isInside =:truee WHERE s.id = :data ";
			Query updateQuery = currentSession.createQuery(updateStd);
			updateQuery.setParameter("truee", false);
			updateQuery.setParameter("data", id);
			
			int resultUpdate = updateQuery.executeUpdate();

			currentSession = sessionFactory.getCurrentSession();
			String hql = "UPDATE HostlerDetail h SET h.isOutside = :isOutside, h.completionTime = :completionTime WHERE h.id = :data ";
			Query query = currentSession.createQuery(hql);
			query.setParameter("completionTime", new Date());
			query.setParameter("isOutside", false);
			query.setParameter("data", hostlerid);

			int resulthql = query.executeUpdate();
			if(resultUpdate != 0 && resulthql != 0) return true;
			return false;
		}
	}
}
