package hostlermanager.model;

import java.sql.Time;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Formula;
import org.springframework.web.bind.annotation.Mapping;

@Entity
public class HostlerDetail {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	private String hostleName;
	private int roomNumber;
	@OneToOne()
	private Student student;
	private int empId;
    @Temporal(TemporalType.TIMESTAMP)
    private Date grantTime;
    @Temporal(TemporalType.TIMESTAMP)
    private Date completionTime;
    private boolean isOutside;	
    private boolean isPermissionGranted;
	private String grantedByempName;
	private String purpose;
	private String location;
    
	


	public Date getCompletionTime() {
		return completionTime;
	}
	public void setCompletionTime(Date completionTime) {
		this.completionTime = completionTime;
	}
	public String getGrantedByempName() {
		return grantedByempName;
	}
	public void setGrantedByempName(String grantedByempName) {
		this.grantedByempName = grantedByempName;
	}
	public Date getGrantTime() {
		return grantTime;
	}
	public void setGrantTime(Date grantTime) {
		this.grantTime = grantTime;
	}
	public boolean isOutside() {
		return isOutside;
	}
	public void setOutside(boolean isOutside) {
		this.isOutside = isOutside;
	}
	public boolean isPermissionGranted() {
		return isPermissionGranted;
	}
	public void setPermissionGranted(boolean isPermissionGranted) {
		this.isPermissionGranted = isPermissionGranted;
	}
	public Student getStudent() {
		return student;
	}
	public void setStudent(Student student) {
		this.student = student;
	}	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHostleName() {
		return hostleName;
	}
	public void setHostleName(String hostleName) {
		this.hostleName = hostleName;
	}
	public int getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(int roomNumber) {
		this.roomNumber = roomNumber;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public HostlerDetail() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HostlerDetail(String hostleName, int roomNumber, String purpose, String location) {
		super();
		this.hostleName = hostleName;
		this.roomNumber = roomNumber;
		this.purpose = purpose;
		this.location = location;
	}

}
