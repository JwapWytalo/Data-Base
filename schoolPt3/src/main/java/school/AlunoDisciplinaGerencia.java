package school;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class AlunoDisciplinaGerencia {

	private static String DB_URL = "jdbc:mysql://localhost/school_pt2";
	private static String DB_USER = "root";
	private static String DB_PASSWORD = "";

	public boolean addResultado(AlunoDisciplina alunoDisciplina) {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();
			String sqlCommand = "INSERT INTO aluno_disciplina (aluno_matr, disciplina_cod, periodo, nota, frequencia) VALUES ('"
					+ alunoDisciplina.getAluno_matr() + "', '" + alunoDisciplina.getDisciplina_cod() + "', '"
					+ alunoDisciplina.getPeriodo() + "', " + alunoDisciplina.getNota() + ", "
					+ alunoDisciplina.getFrequencia() + ")";

			int rowsUpdated = stmt.executeUpdate(sqlCommand, Statement.RETURN_GENERATED_KEYS);

			conn.close();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}