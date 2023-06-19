package school;

import java.sql.SQLException;
import java.util.Scanner;

public class App {

	public static void main(String[] args) throws SQLException {

		Scanner scan = new Scanner(System.in);
		StudentManager studentManager = new StudentManager();
		Student student = new Student();

		int choice = 0;
		int id = 0;
		String name;
		String email;

		do {
			System.out.println();
			System.out.println("-------------------MENU--------------------");
			System.out.println("---------------1-ADICIONAR-----------------");
			System.out.println("------------2-EXIBIR ESTUDANTES------------");
			System.out.println("----------------3-EDITAR-------------------");
			System.out.println("----------------4-DELETAR-------------------");
			System.out.println("-----------------5-SAIR--------------------");

			choice = scan.nextInt();
			scan.nextLine();

			switch (choice) {

			case 1:

				System.out.println("Digite o nome do estudante: ");
				name = scan.nextLine();
				student.setName(name);
				System.out.println("Digite o email do estudante: ");
				email = scan.nextLine();
				student.setEmail(email);

				if (studentManager.addStudent(student)) {
					System.out.println("Inserção bem sucedida!");
				} else {
					System.out.println("Falha na inserção!");
				}

				break;

			case 2:
				studentManager.getStudents();
				break;

			case 3:

				System.out.println("Digite o id do estudante: ");
				id = scan.nextInt();
				student.setId(id);
				scan.nextLine();
				System.out.println("Digite o novo nome do estudante: ");
				name = scan.nextLine();
				student.setName(name);
				System.out.println("Digite o novo email do estudante: ");
				email = scan.nextLine();
				student.setEmail(email);

				if (studentManager.updateStudent(student)) {
					System.out.println("Atualização bem sucedida!");
				} else {
					System.out.println("Falha na atualização!");
				}

				break;

			case 4:
				System.out.println("Digite o id do estudante que voce deseja remover: ");
				id = scan.nextInt();
				student.setId(id);
				scan.nextLine();
				if (studentManager.deleteStudent(student)) {
					System.out.println("Remoção bem sucedida!");
				} else {
					System.out.println("Falha na remoção!");
				}

				break;

			case 5:
				System.out.println("bye");
				break;

			}

		} while (choice != 5);
		scan.close();
	}

}
