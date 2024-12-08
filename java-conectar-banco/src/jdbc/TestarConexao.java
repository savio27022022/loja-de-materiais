package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestarConexao
{
	public static void main(String[] args) throws SQLException
	{
    // String base para conexão
		final String url = "jdbc:mysql//localhost:3306?verifyServerCertificate=false&useSSL=true";
    // Inserir credenciais do banco
		final String usuario = "";
		final String senha = "";
		Connection conexao = DriverManager
				.getConnection(url,usuario,senha);
		System.out.println("Conexão efetuada com sucesso.");
		conexao.close();
	}
}
