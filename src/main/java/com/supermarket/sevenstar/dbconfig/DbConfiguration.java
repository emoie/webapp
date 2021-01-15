package com.supermarket.sevenstar.dbconfig;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfiguration {

	private final static String driverClassName ="com.mysql.cj.jdbc.Driver";
	private final static String databaseURL = "jdbc:mysql://us-cdbr-east-02.cleardb.com:3306/heroku_24b38c9f271006333";
	private final static String databaseUsername = "bde75ebd4a2611";
	private final static String databasePassword = "72095536";
	
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
