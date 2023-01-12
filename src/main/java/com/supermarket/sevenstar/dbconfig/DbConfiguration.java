package com.supermarket.sevenstar.dbconfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfiguration {

	private final static String driverClassName ="com.mysql.cj.jdbc.Driver";
	private final static String databaseURL = "jdbc:mysql://us-cdbr-east-06.cleardb.net:3306/heroku_bc38ea9570226ef";
	private final static String databaseUsername = "ba9fa1b8f892ac";
	private final static String databasePassword = "ee28b816";
	
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
