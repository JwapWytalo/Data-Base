package school;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class StudentManager {

	private int id;
	private String name;
	private String email;

	private static String DB_URL = "jdbc:mysql://localhost/school";
	private static String DB_USER = "admin";
	private static String DB_PASSWORD = "1234";

	void addStudent(String name, String email) throws SQLException {

		Connection conn = null;
		Statement stmt = null;
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

		stmt = conn.createStatement();
		String sqlCommand = "INSERT INTO student (name, email) VALUES ('" + name + "',  '" + email + "')";
		stmt.executeUpdate(sqlCommand, Statement.RETURN_GENERATED_KEYS);

		conn.close();

	}

	void getStudents() throws SQLException {

		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String sqlCommand = "SELECT * FROM student";
		stmt.execute(sqlCommand);

		ResultSet rs = stmt.getResultSet();

		while (rs.next()) {
			int id = rs.getInt("id");
			String name = rs.getString("name");
			String email = rs.getString("email");
			System.out.println("Id: " + id + " - Name: " + name + " - Email: " + email);
		}
		conn.close();
	}

	void putStudent(int id, String name, String email) throws SQLException {
		
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String sqlCommand = "UPDATE student SET name = '" + name + "', email = '" + email + "' WHERE id = " + id;
		stmt.execute(sqlCommand);

		int rowsUpdated = stmt.getUpdateCount();
					
		System.out.println("Rows updated: " + rowsUpdated);

		conn.close();

	}
	
	void deleteStudent(int id) throws SQLException {
		
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();
		
		String sqlCommand = "DELETE FROM student WHERE id = " + id; 
		
		stmt.execute(sqlCommand);
		
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}

/*GRANT ALL ON school.* TO admin@”%” identified by ”1234”;
FLUSH PRIVILEGES;*/

