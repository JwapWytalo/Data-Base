package school;

import java.sql.SQLException;

public class App {

	public static void main(String[] args) throws SQLException{
		
		StudentManager student = new StudentManager();
		
		student.addStudent("wytalo", "wytallo@gmail.com");
		student.getStudents();
		student.putStudent(17, "Adriano", "Adriano@gmail.com");
		student.deleteStudent(17);

	}

}
