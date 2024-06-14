package jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBPoolUtil2 {
	public static Connection makeConnection() {
		// db.properties 파일경로
		String filePath = "D:/projectCode/myjsp/JSPStudy/src/main/java/jdbc/db2.properties";
		ConnectionPool2 pool = ConnectionPool2.getInstance();
		Connection con = null;
		try {

			con = pool.getConnection();
			System.out.println("데이타베이스접속 성공");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("데이타베이스 연결 실패");
		}
		return con;
	}

	public static void dbReleaseClose(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException ex) {}
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException ex) {}
		try {
			if (conn != null) {
				ConnectionPool2 pool = ConnectionPool2.getInstance();
				pool.releaseConnection(conn);
			}
		} catch (Exception ex) {}
	}
	public static void dbReleaseClose(Statement stmt, Connection conn) {
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (SQLException ex) {}
		try {
			if (conn != null) {
				ConnectionPool2 pool = ConnectionPool2.getInstance();
				pool.releaseConnection(conn);
			}
		} catch (Exception ex) {}
	}

}
