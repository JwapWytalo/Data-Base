package App;

import java.sql.SQLException;
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Scanner;
import school.*;

public class App {

	public static void main(String[] args) throws SQLException {

		Scanner scan = new Scanner(System.in);
		AlunoGerencia alunoGerencia = new AlunoGerencia();
		Disciplina disciplina = new Disciplina();
		DisciplinaGerencia disciplinaGerencia = new DisciplinaGerencia();
		Aluno aluno = new Aluno();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		int choice1 = 0;
		int choice2 = 0;

		// aluno
		int matricula = 0;
		String nome;
		String email;
		String telefone;
		String sexo;
		String dataNascF;

		// disciplina
		int creditos;
		int codigo;

		System.out.println();
		System.out.println("-------------------MENU--------------------");
		System.out.println("-----------------1-ALUNOS------------------");
		System.out.println("---------------2-DISCIPLINAS---------------");

		choice1 = scan.nextInt();

		if (choice1 == 1) {

			do {
				System.out.println();
				System.out.println("-------------------MENU--------------------");
				System.out.println("---------------1-ADICIONAR-----------------");
				System.out.println("------------2-EXIBIR ESTUDANTES------------");
				System.out.println("----------------3-EDITAR-------------------");
				System.out.println("----------------4-DELETAR-------------------");
				System.out.println("---------------5-BUSCAR ALUNO---------------");

				choice2 = scan.nextInt();
				scan.nextLine();

				switch (choice2) {

				case 1:

					System.out.println("Digite o nome do estudante: ");
					nome = scan.nextLine();
					aluno.setNome(nome);
					System.out.println("Digite o email do estudante: ");
					email = scan.nextLine();
					aluno.setEmail(email);
					System.out.println("Digite o telefone do estudante: ");
					telefone = scan.nextLine();
					aluno.setTelefone(telefone);
					System.out.println("Digite o sexo do estudante: ");
					sexo = scan.nextLine();
					aluno.setSexo(sexo);
					System.out.println("Digite a data de nascimento do estudante (yyyy-MM-dd): ");
					dataNascF = scan.nextLine();

					try {
						Date dataNasc = dateFormat.parse(dataNascF);
						System.out.println("Data de nascimento: " + dateFormat.format(dataNasc));
						aluno.setData_nasc(dataNasc);
					} catch (ParseException e) {
						System.out.println("Formato de data inválido!");
					}

					if (alunoGerencia.addAluno(aluno)) {
						System.out.println("Inserção bem sucedmatriculaa!");
					} else {
						System.out.println("Falha na inserção!");
					}

					break;

				case 2:
					alunoGerencia.getAlunos();
					break;

				case 3:

					System.out.println("Digite o matricula do estudante: ");
					matricula = scan.nextInt();
					aluno.setMatricula(matricula);
					scan.nextLine();
					System.out.println("Digite o novo nome do estudante: ");
					nome = scan.nextLine();
					aluno.setNome(nome);
					System.out.println("Digite o novo email do estudante: ");
					email = scan.nextLine();
					aluno.setEmail(email);
					System.out.println("Digite o novo telefone do estudante: ");
					telefone = scan.nextLine();
					aluno.setTelefone(telefone);
					System.out.println("Digite o novo sexo do estudante: ");
					sexo = scan.nextLine();
					aluno.setSexo(sexo);
					System.out.println("Digite a nova data de nascimento do estudante (yyyy-MM-dd): ");
					dataNascF = scan.nextLine();
					try {
						Date dataNasc = dateFormat.parse(dataNascF);
						System.out.println("Data de nascimento: " + dateFormat.format(dataNasc));
						aluno.setData_nasc(dataNasc);
					} catch (ParseException e) {
						System.out.println("Formato de data inválido!");
					}

					if (alunoGerencia.updateAluno(aluno)) {
						System.out.println("Atualização bem sucedida!");
					} else {
						System.out.println("Falha na atualização!");
					}

					break;

				case 4:
					System.out.println("Digite o matricula do estudante que voce deseja remover: ");
					matricula = scan.nextInt();
					aluno.setMatricula(matricula);
					scan.nextLine();
					if (alunoGerencia.deleteAluno(aluno)) {
						System.out.println("Remoção bem sucedida!");
					} else {
						System.out.println("Falha na remoção!");
					}

					break;

				case 5:
					System.out.println("Digite o nome do aluno que voce deseja bsucar: ");
					nome = scan.nextLine();
					alunoGerencia.buscarAluno(nome);
				}

			} while (choice2 != 6);

		} else {

			do {
				System.out.println();
				System.out.println("-------------------MENU--------------------");
				System.out.println("----------1-ADICIONAR DISCIPLINA-----------");
				System.out.println("------------2-EXIBIR DISCIPLINAS-----------");
				System.out.println("----------------3-EDITAR-------------------");
				System.out.println("----------------4-DELETAR------------------");
				System.out.println("-----------------5-SAIR--------------------");

				choice2 = scan.nextInt();
				scan.nextLine();

				switch (choice2) {

				case 1:

					System.out.println("Digite o nome da disciplina: ");
					nome = scan.nextLine();
					disciplina.setNome(nome);
					System.out.println("Digite a quantidade de creditos da disciplina: ");
					creditos = scan.nextInt();
					disciplina.setCreditos(creditos);

					if (disciplinaGerencia.addDisciplina(disciplina)) {
						System.out.println("Inserção bem sucedida!");
					} else {
						System.out.println("Falha na inserção!");
					}

					break;

				case 2:
					disciplinaGerencia.getDisciplinas();
					break;

				case 3:

					System.out.println("Digite o codigo da disciplina: ");
					codigo = scan.nextInt();
					disciplina.setCodigo(codigo);
					scan.nextLine();
					System.out.println("Digite o novo nome da disciplina: ");
					nome = scan.nextLine();
					disciplina.setNome(nome);
					System.out.println("Digite a nova quantidade de creditos da disciplina: ");
					creditos = scan.nextInt();
					disciplina.setCreditos(creditos);

					if (disciplinaGerencia.updateDisciplina(disciplina)) {
						System.out.println("Atualização bem sucedida!");
					} else {
						System.out.println("Falha na atualização!");
					}

					break;

				case 4:
					System.out.println("Digite o codigo da disciplina que voce deseja remover: ");
					codigo = scan.nextInt();
					disciplina.setCodigo(codigo);
					scan.nextLine();
					if (disciplinaGerencia.deleteDisciplina(disciplina)) {
						System.out.println("Remoção bem sucedida!");
					} else {
						System.out.println("Falha na remoção!");
					}

					break;

				case 5:
					System.out.println("bye, bye");

				}

			} while (choice2 != 5);

		}

		scan.close();
	}

}
