package com.supermarket.sevenstar.dbconfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfiguration {

	private final static String driverClassName ="com.mysql.cj.jdbc.Driver";
	private final static String databaseURL = "jdbc:mysql://localhost:3306/supermarket";
	private final static String databaseUsername = "root";
	private final static String databasePassword = "";
	
	public static Connection getDatabaseConnection() throws ClassNotFoundException {
		
		Class.forName(driverClassName);
				
		try {
			Connection connection = DriverManager.getConnection(databaseURL, databaseUsername, databasePassword);
			return connection;
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
