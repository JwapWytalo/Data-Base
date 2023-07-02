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
			String sqlCommand = "INSERT INTO disciplina (nome, creditos) VALUES ('" + disciplina.getNome() + "', '"
					+ disciplina.getCreditos() + "')";

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

	public List<Disciplina> getTurma(int codigo, String periodo) throws SQLException {
		List<Disciplina> turmaList = new ArrayList<Disciplina>();
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String consultaTurma = "SELECT d.nome AS disciplina, ad.periodo, COUNT(ad.aluno_matr) AS quantidade_estudantes, "
				+ "MAX(ad.nota) AS maior_nota, MIN(ad.nota) AS menor_nota, AVG(ad.nota) AS media_notas "
				+ "FROM aluno_disciplina ad " + "JOIN disciplina d ON d.codigo = ad.disciplina_cod "
				+ "WHERE ad.disciplina_cod = " + codigo + " AND ad.periodo = '" + periodo + "' "
				+ "GROUP BY d.nome, ad.periodo";

		stmt.execute(consultaTurma);

		ResultSet rs = stmt.getResultSet();

		while (rs.next()) {
			String disciplina = rs.getString("disciplina");
			periodo = rs.getString("periodo");
			int quantidadeEstudantes = rs.getInt("quantidade_estudantes");
			double maiorNota = rs.getDouble("maior_nota");
			double menorNota = rs.getDouble("menor_nota");
			double mediaNotas = rs.getDouble("media_notas");

			System.out.println("Disciplina:" + disciplina + " Periodo:" + periodo + " Quantidade de estudantes:"
					+ quantidadeEstudantes + " Maior nota:" + maiorNota + " Menor nota:" + menorNota
					+ " Media das notas:" + mediaNotas);
		}

		conn.close();
		return turmaList;
	}

	public List<Disciplina> getTurmas() throws SQLException {
		List<Disciplina> turmaList = new ArrayList<Disciplina>();
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();

		String consultaTurma = "SELECT * FROM turmas_info";

		stmt.execute(consultaTurma);

		ResultSet rs = stmt.getResultSet();

		while (rs.next()) {
			String disciplina = rs.getString("disciplina");
			String periodo = rs.getString("periodo");
			int quantidadeEstudantes = rs.getInt("quantidade_estudantes");
			double maiorNota = rs.getDouble("maior_nota");
			double menorNota = rs.getDouble("menor_nota");
			double mediaNotas = rs.getDouble("media_notas");

			System.out.println("Disciplina:" + disciplina + " Periodo:" + periodo + " Quantidade de estudantes:"
					+ quantidadeEstudantes + " Maior nota:" + maiorNota + " Menor nota:" + menorNota
					+ " Media das notas:" + mediaNotas);
		}

		conn.close();
		return turmaList;
	}

}
