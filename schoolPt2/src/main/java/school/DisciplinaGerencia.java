package school;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DisciplinaGerencia {

	private static String DB_URL = "jdbc:mysql://localhost/school_pt2";
	private static String DB_USER = "root";
	private static String DB_PASSWORD = "";

	public boolean addDisciplina(Disciplina disciplina) {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();
			String sqlCommand = "INSERT INTO disciplina (nome, creditos) VALUES ('" + disciplina.getNome() + "', '" + disciplina.getCreditos() + "')";

			int rowsUpdated = stmt.executeUpdate(sqlCommand, Statement.RETURN_GENERATED_KEYS);

			conn.close();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}

	public List<Disciplina> getDisciplinas() throws SQLException {

		List<Disciplina> disciplinasList = new ArrayList<Disciplina>();
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String sqlCommand = "SELECT * FROM disciplina";
		stmt.execute(sqlCommand);

		ResultSet rs = stmt.getResultSet();

		while (rs.next()) {
			Disciplina disciplina = new Disciplina();
			int codigo = rs.getInt("codigo");
			disciplina.setCodigo(codigo);
			;
			String nome = rs.getString("nome");
			disciplina.setNome(nome);
			int creditos = rs.getInt("creditos");
			disciplina.setCreditos(creditos);

			System.out.println("Codigo: " + codigo + " - Nome: " + nome + " - Creditos: " + creditos);
		}

		conn.close();
		return disciplinasList;
	}

	public boolean updateDisciplina(Disciplina disciplina) throws SQLException {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();

			String sqlCommand = "UPDATE disciplina SET nome = '" + disciplina.getNome() + "', creditos = '"
					+ disciplina.getCreditos() + "' WHERE codigo = " + disciplina.getCodigo();

			int rowsUpdated = stmt.executeUpdate(sqlCommand);

			conn.close();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			throw e;

		}
	}

	public boolean deleteDisciplina(Disciplina disciplina) throws SQLException {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();

			String sqlCommand = "DELETE FROM disciplina WHERE codigo = " + disciplina.getCodigo();

			int rowsDeleted = stmt.executeUpdate(sqlCommand);

			conn.close();
			return rowsDeleted > 0;
		} catch (SQLException e) {
			throw e;
		}
	}

}
