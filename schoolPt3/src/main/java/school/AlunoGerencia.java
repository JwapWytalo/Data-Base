package school;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;
import java.text.SimpleDateFormat;
import java.util.Date;

public class AlunoGerencia {

	private static String DB_URL = "jdbc:mysql://localhost/school_pt2";
	private static String DB_USER = "root";
	private static String DB_PASSWORD = "";
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	public boolean addAluno(Aluno aluno) {
		Connection conn = null;
		Statement stmt = null;
		String dataNascimento = dateFormat.format(aluno.getData_nasc());

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();
			String sqlCommand = "INSERT INTO aluno (nome, email, telefone, sexo, data_nascimento) VALUES ('"
					+ aluno.getNome() + "',  '" + aluno.getEmail() + "', '" + aluno.getTelefone() + "', '"
					+ aluno.getSexo() + "', '" + dataNascimento + "' )";

			int rowsUpdated = stmt.executeUpdate(sqlCommand, Statement.RETURN_GENERATED_KEYS);

			conn.close();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}
	public List<Aluno> getAlunos() throws SQLException {

	    List<Aluno> alunosList = new ArrayList<Aluno>();
	    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	    Statement stmt = conn.createStatement();

	    String sqlCommand = "SELECT * FROM alunos_info;";
	    stmt.execute(sqlCommand);

	    ResultSet rs = stmt.getResultSet();

	    while (rs.next()) {
	        Aluno aluno = new Aluno();
	        int matricula = rs.getInt("matricula");
	        aluno.setMatricula(matricula);
	        String nome = rs.getString("nome");
	        aluno.setNome(nome);
	        String email = rs.getString("email");
	        aluno.setEmail(email);
	        String telefone = rs.getString("telefone");
	        aluno.setTelefone(telefone);
	        String sexo = rs.getString("sexo");
	        aluno.setSexo(sexo);
	        double media = rs.getDouble("media");
	        String distincao = rs.getString("distincao");
	        

	        System.out.println("Matricula: " + matricula + " - Nome: " + nome + " - Email: " + email + " - Telefone: "
	                + telefone + " - Sexo: " + sexo + " - Média: " + media + " - Distinção: " + distincao);
	        alunosList.add(aluno);
	    }

	    conn.close();
	    return alunosList;
	}


	public boolean updateAluno(Aluno aluno) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		String dataNascimento = dateFormat.format(aluno.getData_nasc());

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();

			String sqlCommand = "UPDATE aluno SET nome = '" + aluno.getNome() + "', email = '" + aluno.getEmail()
					+ "', telefone = '" + aluno.getTelefone() + "', data_nascimento = '" + dataNascimento
					+ "', sexo = '" + aluno.getSexo() + "' WHERE matricula = " + aluno.getMatricula();

			int rowsUpdated = stmt.executeUpdate(sqlCommand);

			conn.close();
			return rowsUpdated > 0;
		} catch (SQLException e) {
			throw e;

		}
	}

	public boolean deleteAluno(Aluno aluno) throws SQLException {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			stmt = conn.createStatement();

			String sqlCommand = "DELETE FROM aluno WHERE matricula = " + aluno.getMatricula();

			int rowsDeleted = stmt.executeUpdate(sqlCommand);

			conn.close();
			return rowsDeleted > 0;
		} catch (SQLException e) {
			throw e;
		}
	}

	public List<Aluno> buscarAluno(String string) throws SQLException {
	    List<Aluno> estudantesList = new ArrayList<Aluno>();
	    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	    Statement stmt = conn.createStatement();

	    String sqlCommand = "SELECT a.matricula, a.nome, a.email, a.telefone, a.sexo, a.distincao, AVG(ad.nota) AS media " +
	                        "FROM aluno a " +
	                        "LEFT JOIN aluno_disciplina ad ON a.matricula = ad.aluno_matr " +
	                        "WHERE LOWER(a.nome) LIKE '%" + string.toLowerCase() + "%' OR LOWER(a.email) LIKE '%" + string.toLowerCase() + "%'" +
	                        "GROUP BY a.matricula, a.nome, a.email, a.telefone, a.sexo, a.distincao";
	    stmt.execute(sqlCommand);

	    ResultSet rs = stmt.getResultSet();

	    while (rs.next()) {
	        Aluno aluno = new Aluno();
	        int matricula = rs.getInt("matricula");
	        aluno.setMatricula(matricula);
	        String nome = rs.getString("nome");
	        aluno.setNome(nome);
	        String email = rs.getString("email");
	        aluno.setEmail(email);
	        String telefone = rs.getString("telefone");
	        aluno.setTelefone(telefone);
	        String sexo = rs.getString("sexo");
	        aluno.setSexo(sexo);
	        double media = rs.getDouble("media");
	        String distincao = rs.getString("distincao");

	        aluno.setMedia(media);
	        aluno.setDistincao(distincao);

	        System.out.println("Matricula: " + matricula + " - Nome: " + nome + " - Email: " + email + " - Telefone: "
	                + telefone + " - Sexo: " + sexo + " - Média: " + media + " - Distinção: " + distincao);

	        estudantesList.add(aluno);
	    }

	    conn.close();
	    return estudantesList;
	}

	
	public List<Aluno> getResultado(int matricula) throws SQLException {
		List<Aluno> estudantesList = new ArrayList<Aluno>();
		Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		Statement stmt = conn.createStatement();
 
		String consultaHistorico = "SELECT d.nome AS disciplina, ad.periodo, ad.nota, ad.frequencia, " +
                "(SELECT AVG(nota) FROM aluno_disciplina WHERE disciplina_cod = ad.disciplina_cod) AS media_disciplina " +
                "FROM aluno_disciplina ad " +
                "JOIN disciplina d ON d.codigo = ad.disciplina_cod " +
                "WHERE ad.aluno_matr = " + matricula;

		
		stmt.execute(consultaHistorico);

		ResultSet rs = stmt.getResultSet();



		while (rs.next()) {
			
			String disciplina = rs.getString("disciplina");
            String periodo = rs.getString("periodo");
            double nota = rs.getDouble("nota");
            double frequencia = rs.getDouble("frequencia");

            System.out.println("Disciplina: " + disciplina);
            System.out.println("Período: " + periodo);
            System.out.println("Nota: " + nota);
            System.out.println("Frequência: " + frequencia+ "%");
            System.out.println("--------------------");
		}

		conn.close();
		return estudantesList;
	}


}
